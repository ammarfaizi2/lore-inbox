Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266760AbSL3G3s>; Mon, 30 Dec 2002 01:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbSL3G3s>; Mon, 30 Dec 2002 01:29:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:27900 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266760AbSL3G3q>;
	Mon, 30 Dec 2002 01:29:46 -0500
Message-ID: <3E0FE9CA.89FCC748@digeo.com>
Date: Sun, 29 Dec 2002 22:38:02 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aniruddha M Marathe <aniruddha.marathe@wipro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 53mm2 kernel panic during boot
References: <94F20261551DC141B6B559DC49108672044437@blr-m3-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2002 06:38:02.0976 (UTC) FILETIME=[00B4AE00:01C2AFCE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aniruddha M Marathe wrote:
> 
> I am getting kernel panic during boot-up after applying mm2 patch. I did the whole compilation again but the problem persisits.
> 
> Shared 3rd level pagetable on
> 
> Details
> 
> Call trace:
> 
>  ramfs_get_inode+0x7b/0x120
> Sget+0x197/0x1b0
>  ramfs_fill_super+0x2c/0x60
> Get_sb_nodev+0x3a/0x70
> Do_kern_mount+0x41/0xa0
> Ramfs_fill_super+0x0/0x60
> _stext+0x0/0x30
> _stext+0x0/0x30
> 

Sorry, I can neither reproduce nor explain this.  Please send me a copy
of your .config and I'll try to make it happen here.  Thanks.

Are you using initrd or devfs?
