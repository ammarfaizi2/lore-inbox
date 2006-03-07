Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWCGWRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWCGWRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 17:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWCGWRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 17:17:17 -0500
Received: from hc652ae31.dhcp.vt.edu ([198.82.174.49]:9613 "EHLO
	hc652ae31.dhcp.vt.edu") by vger.kernel.org with ESMTP
	id S964783AbWCGWRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 17:17:16 -0500
Message-Id: <200603072217.k27MH6IJ003533@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm3 
In-Reply-To: Your message of "Tue, 07 Mar 2006 02:19:29 PST."
             <20060307021929.754329c9.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20060307021929.754329c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1141769826_3290P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Mar 2006 17:17:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1141769826_3290P
Content-Type: text/plain; charset=us-ascii

On Tue, 07 Mar 2006 02:19:29 PST, Andrew Morton said:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/

Seen during early boot from the initrd, while the initrd was firing up a
'lvm vgscan' to get the root filesystem accessible.. 2.6.15-rc5-mm2 didn't do this.
Dell laptop, Pentium4, UP kernel...

[   16.959458] Freeing unused kernel memory: 176k freed
[   16.984855] Write protecting the kernel read-only data: 998k
[   17.044106] Time: tsc clocksource has been installed.
[   17.600897] BUG: sleeping function called from invalid context at mm/slab.c:2751
[   17.625891] in_atomic():1, irqs_disabled():0
[   17.650461]  [<c0103aba>] show_trace+0xd/0xf
[   17.674759]  [<c0103b5b>] dump_stack+0x17/0x19
[   17.698533]  [<c010ff3c>] __might_sleep+0x86/0x90
[   17.722149]  [<c015155a>] kmem_cache_alloc+0x27/0x82
[   17.745520]  [<c015baf1>] bd_claim_by_kobject+0x77/0x1b1
[   17.768657]  [<c02a55a4>] open_dev+0x54/0x72
[   17.791983]  [<c02a5c8b>] dm_get_device+0x13f/0x336
[   17.815254]  [<c02a656c>] linear_ctr+0x7f/0xbb
[   17.838389]  [<c02a5996>] dm_table_add_target+0x10e/0x233
[   17.861491]  [<c02a7c82>] table_load+0xc9/0x1a5
[   17.884366]  [<c02a796b>] ctl_ioctl+0x208/0x246
[   17.906866]  [<c01653f2>] do_ioctl+0x4e/0x67
[   17.929035]  [<c0165657>] vfs_ioctl+0x24c/0x25f
[   17.950782]  [<c01656b1>] sys_ioctl+0x47/0x62
[   17.971931]  [<c0102707>] syscall_call+0x7/0xb
[   18.426629] kjournald starting.  Commit interval 5 seconds



--==_Exmh_1141769826_3290P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEDgZicC3lWbTT17ARAmnDAJ9mOjvT3Fv73ug4l3a92UUcz/7pqwCgj7Yc
qQFRXlAQsq/97m+0v8VMRbs=
=TLxD
-----END PGP SIGNATURE-----

--==_Exmh_1141769826_3290P--
