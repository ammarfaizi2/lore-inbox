Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbTLIIGx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 03:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266027AbTLIIGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 03:06:53 -0500
Received: from cafe.hardrock.org ([142.179.182.80]:51859 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S266025AbTLIIGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 03:06:49 -0500
Date: Tue, 9 Dec 2003 01:06:48 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.23-uv1 patch set released
Message-ID: <Pine.LNX.4.51.0312090102030.21759@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
The Update Version patchset is a set of patches which include only fatal
compile/runtime bug fixes and security updates for the current kernel
version.  This patch set can be used in production environments for those
who wish to run 2.4.23, but do not use vendor kernels and at the same time
require patches which add to the stability of the current release kernel
version.  This is a patch set only, it does not include kernel source.

Current version is 2.4.23-uv1 and contains many patches pulled from bit keeper.

The complete URL to the patch set is
http://www.hardrock.org/kernel/current-updates/linux-2.4.23-updates.patch

Individual patches can be viewed and downloaded from
http://www.hardrock.org/kernel/current-updates/

This patch set only contains and will only contain security updates and
fixes for the latest kernel version.  Each individual patch contains text
WRT the patch itself and the creator of the patch, I will try to keep doing
that as standard reference for the complete collection.

Please send bug reports to jbourne@hardrock.org and CC
linux-kernel@vger.kernel.org.

Patch specifics are:
linux-2.4.23-updates.patch: Contains all the patches below.         

linux-2.4.23-extraversion.patch: Updated the extraversion in the Makefile

linux-2.4.23-file_lock_acct.patch: Remove broken file lock accounting

linux-2.4.23-ht-detect.patch: Fixup smb_boot_cpus(): Fix HT detection bug

linux-2.4.23-ipfw_compat_oops.patch: fix for a known bug in the netfilter

linux-2.4.23-ll_rw_blk_race_fix.patch: from -aa tree: Fix potential fsync()
        race condition

linux-2.4.23-lockd_reclaim.patch: Drop module count if lockd reclaimer
        thread failed to start

linux-2.4.23-no_idt.patch: fix reboot/no_idt bug

linux-2.4.23-oom_kill.patch: out_of_memory() locking issue

linux-2.4.23-rbs_clobber.patch: ia64: Fix a bug in sigtramp() which
        corrupted ar.rnat when unwinding across a signal trampoline
        (in user space).  Reported by Laurent Morichetti.

linux-2.4.23-root_rlim.patch: Make root a special case for per-user process
        limits.

linux-2.4.23-rtc-compile.patch: Patch to allow RTC to compile properly on
        some systems, see http://lkml.org/lkml/2003/12/1/150

Regards
James Bourne

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  
