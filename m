Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289609AbSAOTlu>; Tue, 15 Jan 2002 14:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289608AbSAOTlk>; Tue, 15 Jan 2002 14:41:40 -0500
Received: from ns.suse.de ([213.95.15.193]:58119 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289592AbSAOTlg>;
	Tue, 15 Jan 2002 14:41:36 -0500
Date: Tue, 15 Jan 2002 20:40:48 +0100
From: Dave Jones <davej@suse.de>
To: David Ford <david+cert@blue-labs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2 - reiserfs::procfs.c fails compile
Message-ID: <20020115204048.H32088@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	David Ford <david+cert@blue-labs.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3C448241.7000104@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C448241.7000104@blue-labs.org>; from david+cert@blue-labs.org on Tue, Jan 15, 2002 at 02:25:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 02:25:53PM -0500, David Ford wrote:
 > Looks like a quick fix, ..I haven't inspected it tho.
 > procfs.c:80: conversion to non-scalar type requested
 > procfs.c: In function `reiserfs_super_in_proc':
 > procfs.c:137: conversion to non-scalar type requested
 > procfs.c: In function `reiserfs_per_level_in_proc':
 > procfs.c:217: conversion to non-scalar type requested
 > procfs.c: In function `reiserfs_bitmap_in_proc':
 > procfs.c:296: conversion to non-scalar type requested
 > procfs.c: In function `reiserfs_on_disk_super_in_proc':
 > procfs.c:337: conversion to non-scalar type requested
 > procfs.c: In function `reiserfs_oidmap_in_proc':
 > procfs.c:390: conversion to non-scalar type requested
 > procfs.c: In function `reiserfs_journal_in_proc':
 > procfs.c:441: conversion to non-scalar type requested
 > procfs.c:494: incompatible type for argument 1 of `bdevname'
 > procfs.c: In function `reiserfs_proc_register':
 > procfs.c:581: aggregate value used where an integer was expected
 > make[3]: *** [procfs.o] Error 1
 > make[3]: Leaving directory `/usr/local/src/linux/fs/reiserfs'
 > make[2]: *** [first_rule] Error 2
 > make[2]: Leaving directory `/usr/local/src/linux/fs/reiserfs'

 This is fixed in -dj for a week or two now. I'll put up
 a resync against 2.5.2 in a few hours after I'm happy it
 passes the 'builds & boots' test on a few more boxes.

 Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
