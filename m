Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269683AbUICNTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269683AbUICNTs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269675AbUICNTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:19:47 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:57791 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S269687AbUICNQj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:16:39 -0400
Date: Fri, 3 Sep 2004 15:16:19 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <642078516.20040903151619@tnonline.net>
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: Paul Jakma <paul@clubi.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jamie Lokier <jamie@shareable.org>, Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
In-Reply-To: <1094216718.2679.30.camel@shaggy.austin.ibm.com>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain>
 <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <1094118362.4847.23.camel@localhost.localdomain>
 <20040902161130.GA24932@mail.shareable.org>
 <Pine.LNX.4.61.0409030028510.23011@fogarty.jakma.org>
 <1835526621.20040903014915@tnonline.net>
 <1094165736.6170.19.camel@localhost.localdomain>
 <32810200.20040903020308@tnonline.net>
 <Pine.LNX.4.61.0409030112080.23011@fogarty.jakma.org>
 <142794710.20040903023906@tnonline.net>
 <1094216718.2679.30.camel@shaggy.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> On Thu, 2004-09-02 at 19:39, Spam wrote:
>>   
>> 
>> > On Fri, 3 Sep 2004, Spam wrote:
>> 
>> >>  Yes, some archive types can't be partially unzipped either. But my
>> >>  point is that it wouldn't be transparent to the application/user in
>> >>  the same way.
>> 
>> > It doesnt matter whether it is transparent to the application. It can
>> > be the application which implements the required level of 
>> > transparency.
>> 
>> > User doesnt care what provides the transparency or how it's 
>> > implemented.
>> 
>>   Indeed. I hope I didn't say otherwise :). Just that I think it will
>>   be very difficult to have this transparency in all apps.

> You're missing the point.  We don't need transparency in all apps.  You
> can write an application to be as transparent as you want, but you don't
> need every app to to understand every file format.

  No, but not every user "can write an application" either, or even
  have the skills to apply patches. What I was talking about wasn't
  just tar, which itself isn't the best example anyway, but the idea
  that users can load plugins that will extend the functionality of
  their filesystems. That idea seem to be to be _much_ better than
  trying to teach every user how to write applications or patch
  existing ones.

>>  Just
>>   thinking of "nano file.jpg/description.txt" or "ls
>>   file.tar/untar/*.doc".

> I don't do much image editting, but I'm sure there are applications that
> let you edit the description in a text file.  You can even create a
> script that extracts it, runs nano, and puts it back into the jpeg.

> This works for me:
> tar -tf file.tar | grep '\.doc'

> There are userland tools that deal with hundreds of file formats. Use
> the tool you need, rather than try to have the kernel do everything.

  No, but if I wanted to have an encryption plugin active for some of
  my files or directories then why should I not be able to? I still
  want to edit, view and save my encrypted files.

  Again, this was just an example of what could be done with plugins.
  It is not said that every conceivable plugin will be written, nor
  loaded per default. Even though plugins cannot today be dynamically
  used, they will be eventually. Reiser4 is still very young.

  Please separate your thoughts for specific plugins from those of the
  idea to have plugins at all.

  ~S

>>  Sure in some environments like Gnome it could
>>   work, but it still doesn't for the rest of the flora of Linux
>>   programs.

> Just choose the right program.  tar groks tar files, not ls.


