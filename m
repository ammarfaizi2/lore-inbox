Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbUDMRFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 13:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUDMRFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 13:05:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59835 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263589AbUDMRFl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 13:05:41 -0400
Message-ID: <407C1DD8.5060909@pobox.com>
Date: Tue, 13 Apr 2004 13:05:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RFT] please test the big post-2.6.5 merge
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The snapshot 2.6.5-bk1 is out, and has a _ton_ of changes in it that 
have been waiting to go upstream for several weeks.  This snapshot 
includes many more _major_ changes than most snapshots, so I wanted to 
call special attention to it, and request testing and feedback from 
linux-kernel denizens.

Changelog describing the 457 changes in this snapshot:
http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.5-bk1.log

Patch:
http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.5-bk1.bz2

Short, jgarzik-generated list of major changes that probably want testing:
* non-exec stack support
* much better block I/O unplugging (I/O scalability)
* laptop mode
* lots of VM work (often related to I/O or Hugh's rmap/anonvma stuff)
* 4K stacks
* updated software suspend
* early x86 boot changes
* several ext2/ext3/jbd improvements
* new "CFQ" I/O scheduler
* queue congestion hooks
* DM, MD fixes (some related to the queue congestion/unplugging changes)
* posix message queue work from Manfred
* lightweight auditing framework
* reiserfs fixes and features
* readahead tweaks and fixes
* writeback tweaks
* direct-IO and AIO fixes and speed-ups
* shrinkage from Matt Mackall's -tiny tree
* /dev/urandom scalability
* update slab for per-arch alignments
* initramfs fix
* knfsd fixes and updates
* nfs client fixes/updates
* pcmcia update
* SATA update
* selinux update
* v4l update
* various arch updates: H8300, s/390, ppc32, ppc64, x86-64, nommu, arm, ...




