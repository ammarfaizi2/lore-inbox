Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269520AbUICQsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269520AbUICQsk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269456AbUICQrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:47:07 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:11934 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S269416AbUICQpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:45:36 -0400
Date: Fri, 3 Sep 2004 17:43:11 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Spam <spam@tnonline.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent
 semantic changes with reiser4)
In-Reply-To: <142794710.20040903023906@tnonline.net>
Message-ID: <Pine.LNX.4.61.0409031730000.23011@fogarty.jakma.org>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <1094118362.4847.23.camel@localhost.localdomain> <20040902161130.GA24932@mail.shareable.org>
 <Pine.LNX.4.61.0409030028510.23011@fogarty.jakma.org> <1835526621.20040903014915@tnonline.net>
 <1094165736.6170.19.camel@localhost.localdomain> <32810200.20040903020308@tnonline.net>
 <Pine.LNX.4.61.0409030112080.23011@fogarty.jakma.org> <142794710.20040903023906@tnonline.net>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, Spam wrote:

>  Indeed. I hope I didn't say otherwise :).

Sure.

>  Just that I think it  will
>  be very difficult to have this transparency in all apps. Just
>  thinking of "nano file.jpg/description.txt" or "ls
>  file.tar/untar/*.doc". Sure in some environments like Gnome it could
>  work, but it still doesn't for the rest of the flora of Linux
>  programs.

"will it be transparent for all apps?", whether that's worth doing 
depends on the technical implications. Thankfully we have Al and 
Linus to make the judgement call on that ;)

Personally, I think that if GNOME can provide transparency for GNOME 
users, I think that's probably enough - unless there are literally no 
issues in adding some kind of VFS support.

The nano / ls /tar user is likely a very different user to the GNOME 
user. That user is also likely to appreciate the problems with 
backups and such more.

Anyway, userspace transparency is sufficient for most classes of 
users. Only reason to provide some kernel support is if it makes 
sense ("but not all apps can use GNOME transparency" not being one of 
those reasons).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Beat your son every day; you may not know why, but he will.
