Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268108AbUIBJzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268108AbUIBJzK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268067AbUIBJzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:55:10 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:9169 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268108AbUIBJxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:53:20 -0400
Date: Thu, 2 Sep 2004 11:52:49 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1117111836.20040902115249@tnonline.net>
To: Hans Reiser <reiser@namesys.com>
CC: Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <4136E0B6.4000705@namesys.com>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain>
 <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com>
 <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
 <4136A14E.9010303@slaphack.com>
 <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
 <4136C876.5010806@namesys.com>
 <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
 <4136E0B6.4000705@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Linus Torvalds wrote:

>> But _my_ point is, no user program is going to take _advantage_ of
>>
>>anything that only one filesystem on one system offers.
>>  
>>
> Apple does not have this problem....

> and yes, the apps will take advantage of it, which is different from
> depending on it.  If you use the wrong fs you will lose some of the 
> features of the app.

> For 30 years nothing much has happened in Unix filesystem semantics 
> because of sheer cowardice (excepting Clearcase, which priced itself
> into a niche market).   It is 25 years past time for someone to change
> things.  That someone will have first mover advantage, and the more 
> little semantic features possessed the more lure there will be to use it
> which will increase market share which will lure more apps into 
> depending on it and in a few years the other filesystems will 
> (deservedly) have only a small market share because the apps won't all
> work on them.

> Besides, there are enhancements which are simply compelling.  You can
> write a dramatically better performance version control system with a
> much simpler design if the FS is atomic.    Our transaction manager 
> first draft was written by a version control guy, and he would probably
> be happy to tell you how  lack of atomicity other than rename makes 
> version control software design hideous.

  Btw, version control for ordinary files would be a great feature. I
  think something like it is available through Windows 2000/3 server.
  Isn't it called "Shadow Copies". It works over network shares. :)

  It allows you to restore previous versions of the file even if you
  delete or overwrite it.

  Features like this do make a good point and helps protecting data -
  something that is important IMHO.
  
  http://www.microsoft.com/resources/documentation/windowsserv/2003/standard/proddocs/en-us/overview_snapshot.asp


> We have the performance lead.  By next year we will be stable enough for
> mission critical servers, and then we start the serious semantic 
> enhancements.

> If you don't embrace progress, then you doom Linux to following behind,
> because the guys at Apple are pretty aggressive now that Jobs is back,
> and they WILL change the semantics, and they will do so in compelling
> ways, and Linux will be reduced to aping them when it should be leading
> them.

> Hans

