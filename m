Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbTBGQLI>; Fri, 7 Feb 2003 11:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265960AbTBGQLI>; Fri, 7 Feb 2003 11:11:08 -0500
Received: from horkos.telenet-ops.be ([195.130.132.45]:56012 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S265939AbTBGQLG>; Fri, 7 Feb 2003 11:11:06 -0500
Date: Fri, 7 Feb 2003 17:20:44 +0100 (CET)
From: Wim Vinckier <wim-raid@tisnix.be>
X-X-Sender: <wim@nooks.wimpunk.com>
To: Stephan van Hienen <raid@a2000.nu>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: fsck out of memory
In-Reply-To: <Pine.LNX.4.53.0302071711260.1306@ddx.a2000.nu>
Message-ID: <Pine.LNX.4.33.0302071719520.13536-100000@nooks.wimpunk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2003, Stephan van Hienen wrote:

> On Fri, 7 Feb 2003, Wim Vinckier wrote:
>
> > I'm just wondering why you are using ext2 in stead of ext3 or reiserfs...
> i'm running ext3
> but crash was heavy enough for removing the journal info :(
>

I would really use fsck.ext3...  I guess it will give a lot less errors...

> > I would still give it a try to boot my system without mounting the raid so
> > you just can wait untill the raid is synchronized.  Once this is ready,
> i can mount the filesystem, but get errors on accessing some files
> so i prefer to run fsck on it (and restore the journal info)
>
> > you can check your raid.  BTW, I had two fans blowing air over my
> > harddisks but I got the crash because I used the normal flat IDE-cable...
> > I suppose you really checked the heat of the disks?
> yes i did
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

------------------------------------------------------------------------
Wim VINCKIER
Wim-Raid@tisnix.be                                         ICQ 100545109
------------------------------------------------------------------------
'Windows 98 or better required' said the box... so I installed linux

