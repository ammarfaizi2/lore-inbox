Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263719AbTH1Fo1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 01:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbTH1Fo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 01:44:27 -0400
Received: from cafe.hardrock.org ([142.179.182.80]:13184 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S263719AbTH1FC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 01:02:56 -0400
Date: Wed, 27 Aug 2003 23:02:54 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-uv1 patch set released
Message-ID: <Pine.LNX.4.44.0308272244030.1515-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I've placed the update version 1 (2.4.22-uv1) patch set at 
http://www.hardrock.org/kernel/current-updates/ for those who want to
download it. 

This patch set only contains and will only contain security updates and
fixes for the latest kernel version.  Each individual patch contains text
WRT the patch itself and the creator of the patch, I will try to keep doing
that as standard reference for the complete collection.

Please send bug reports to jbourne@hardrock.org.



The individual patches are:

linux-2.4.22-extraversion.patch: Updated the extraversion in the Makefile

linux-2.4.22-amd64-compile.patch: Fixes broken x86-64 compilation

linux-2.4.22-amd76x_pm.c-crash.patch: Fix amd67x_pm.c crash with no chipsets
        / CONFIG_HOTPLUG

linux-2.4.22-atm-pca-200epc.patch: when clip isnt a module, the common code
        try to manipulate the module count while fails.

linux-2.4.22-hardirq-race.patch: Fix possible IRQ handling SMP race

linux-2.4.22-initrd-netboot.patch: Handle -EBUSY in mount_block_root for
        netboot

linux-2.4.22-pcwd-unload-oops.patch: This patch is from Alan Cox and fixes 
        problems when pcwd driver is loaded while there is no pcwd hardware
        installed.

linux-2.4.22-updates.patch: All the above patches rolled into a single
	patch.

Regards
James Bourne

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

