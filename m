Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268474AbUIBT4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268474AbUIBT4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268762AbUIBTwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:52:22 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:25987 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268767AbUIBTuk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:50:40 -0400
Date: Thu, 2 Sep 2004 21:50:31 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1591214030.20040902215031@tnonline.net>
To: Linus Torvalds <torvalds@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
In-Reply-To: <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain>
 <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <1094118362.4847.23.camel@localhost.localdomain>
 <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  



> On Thu, 2 Sep 2004, Alan Cox wrote:
>>
>> On Mer, 2004-09-01 at 21:50, Linus Torvalds wrote:
>> > and quite frankly, I think you can do the above pretty much totally in
>> > user space with a small library and a daemon (in fact, ignoring security
>> > issues you probably don't even need the daemon). And if you can prototype
>> > it like that, and people actually find it useful, I suspect kernel support
>> > for better performance might be possible.
>> 
>> Gnome already supports this in the gnome-vfs2 layer. "MC" has supported
>> it since the late 1990's.

> And nobody has asked for kernel support that I know of.

  Actually. Doesn't matter if it is in kernel or not for the users as
  long as it works.

  The problem is that I do not see either Gnome or KDE to ever get
  along to form one standard that everyone will use. Their libraries
  are huge and memory hogging which so many Linux users just do not
  like. What if a user doesn't want KDE or Gnome? Would all files
  created with either be broken?

  I doubt that something like file streams and meta-data can
  successfully be implemented purely in user-space and get the same
  support (ie be used by many programs) if this change doesn't come
  from the kernel. I just do not see it happen.

> So either "it just works" in user space, or people haven't figured out the
> kernel could help them. Or decided it's not worth it, exactly because
> they'd still have to support systems/filesystems that can't be converted.

> 		Linus

