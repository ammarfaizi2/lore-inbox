Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269570AbUICFWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269570AbUICFWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 01:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269569AbUICFWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 01:22:20 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:60093 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269534AbUICFWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 01:22:14 -0400
Message-ID: <4137FF87.8080002@namesys.com>
Date: Thu, 02 Sep 2004 22:22:15 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Masover <ninja@slaphack.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Frank van Maarseveen <frankvm@xs4all.nl>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Christoph Hellwig <hch@lst.de>, fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus> <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk> <4137B5F5.8000402@slaphack.com> <Pine.LNX.4.58.0409021717220.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409021717220.2295@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Thu, 2 Sep 2004, David Masover wrote:
>  
>
>>reiser4 kernel will contain knowledge of fs type contained in a file.
>>    
>>
Whoa!  No it won't.  It will allow you to create a metafile named type 
if you choose.  Or maybe a metadirectory named types, I don't really 
care much about this stuff yet, we need to do other things to the 
semantics more urgently than this, Typing requires a lot of cooperation 
from user space apps.  I don't really expect to have that much social 
pull on the issue, but if someone chooses to design their app to use a 
types metadirectory, I don't mind accomodating on it.  I apologize if  
from my saying that I gave the impression that I think files should be 
strongly typed.

I am quite well aware of the disadvantages of OS/400 hindering usability 
with type information, as well the advantages of having types available 
for those that want to look at them.....

>
>That's a disaster, btw.
>  
>
In every implementation so far it has been a net disaster, because OS 
designers who type things have been willing to make users pay attention 
to type when they don't want to.  Sometimes trying to make too much out 
of something makes it a mistake when being a bit more laid back would 
make it ok.  Me, I am so laid back, I prefer to work on other features 
for a few years first.....;-)

>There is no one "fs type" of a file. Files have at _least_ one type
>(bytestream), but most have more. Which is why automatically doing the
>right thing (in the sense you seem to want) in kernel space is simply not
>possible.
>
>			Linus
>
>
>  
>

