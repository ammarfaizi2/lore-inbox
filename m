Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312326AbSCUAwa>; Wed, 20 Mar 2002 19:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312328AbSCUAwU>; Wed, 20 Mar 2002 19:52:20 -0500
Received: from ns.suse.de ([213.95.15.193]:62217 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312327AbSCUAwM>;
	Wed, 20 Mar 2002 19:52:12 -0500
Date: Thu, 21 Mar 2002 01:52:08 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.7-dj1
Message-ID: <20020321015208.F30820@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resync, add compile fixes, simmer for 30 mins on low heat.
Add random pending patches to taste.

Still untested beyond 'it compiles', handle with care.
Mostly a 'standing still' release, I'll catch up with 2.4.19pre next time.

As usual,..
Patch against 2.5.7 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.7-dj1
o   Various x86-64 compile fixes.			(Me, Andi Kleen)
o   Fix up hfs superblock cleanup typo.			(Brian Gerst)
o   Remove 2.1.x/2.3.x checks from rocket driver.	(William Stinson)
o   JFS compile fixes.					(Dave Kleikamp)
o   pci_alloc_consistent ZONE_NORMAL fix.		(Badari Pulavarty)
o   v4l unregister with open file handles fix.		(Gerd Knorr)
o   ACPI throttling fixes.				(Dominik Brodowski)
o   Updated NFS root_server_path patch.			(Martin Schwenke)
o   Backout problematic sym53c8xx_2 changes.		(Douglas Gilbert)
o   Fix up one of my MCE SNAFU's.			(Douglas Gilbert)
    | Also make it AMD only for now, pending further investigation.
o   Support for Belkin Wireless card.			(Brendan W. McAdams)
o   input/gameport makefile & config.in fixes.		(Steven Cole)
o   UDF write compile fix.


2.5.6-dj2
o   machine check background checker SMP improvements.	(Me)
o   Hush INVALIDATE_AGID noise on Toshiba DVD drives.	(Jens Axboe)
o   Remove delayed vfree() in ppp_deflate.		(David Woodhouse)
o   Fix devfs 64-bit portability issues.		(Carsten Otte)
o   UFS blocksize fix.					(Zwane Mwaikambo)
o   Fix proc race on task_struct->sig.			(Chris Mason)
o   Pull NFS server IP from root_server_path.		(Martin Schwenke)
o   Fix broken tristate in ALSA config.			(Steven Cole)
o   Work around mpc_apicid > MAX_APICS problem.		(James Cleverdon)
o   cs4281 OSS compile fix.				(Sebastian Droege)
o   Fix locking in ATM device allocation.		(Maksim Krasnyanskiy)
o   Fix MSDOS filesystem option mistreatment.		(Rene Scharfe)
o   Increase number of JFS transaction locks.		(Steve Best)
o   page_to_phys() fix for >4GB pages on x86.		(Badari Pulavarty)
o   Append kernel config to zImage.			(Randy Dunlap)
    | See also scripts/extract-ikconfig
o   Remove useless check from shmem_link()		(Alexander Viro)
o   Enable Natsemi MMX extensions.			(Zwane Mwaikambo)
o   Superblock cleanups for isofs,udf & bfs.		(Brian Gerst)
o   request_region() checking for hisax avm_a1		(Dan D Carpenter)
o   uninitialise lots of static vars in net/		(William Stinson)
o   D-Link DE620 janitor work.				(Karol Kasprzak)
o   Netfilter conntrack compile fix.			(Christopher Barton)


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
