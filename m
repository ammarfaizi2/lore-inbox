Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264879AbUEVCOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUEVCOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUEVCN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:13:29 -0400
Received: from pop.gmx.net ([213.165.64.20]:23968 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264992AbUEVCJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:09:45 -0400
X-Authenticated: #199736
Date: Thu, 20 May 2004 00:04:48 +0200
From: Corin Langosch <corinl@gmx.de>
Reply-To: Corin Langosch <corinl@gmx.de>
X-Priority: 3 (Normal)
Message-ID: <1457910676.20040520000448@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: dual opteron problems, tyan 2870 board
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

i just bought a new 2x244 opteron,tyan tiger k8s 2870,
4gb registered ecc ram system. no addional cards
inserted, only one IDE and one SATA device.

i tried to run the setup with the original debian
kernel 2.6.6-1-k7-smp, but the system hangs right
after the line "initrd-tools: 0.1.69".

so i downloaded the sources for 2.6.6 and compiled
them myself, optimized for dual opteron. unluckily
exactly the same happens.

when i enable the apic 2.0 support in the bios, the
system hangs even ealier right after the first
"calibrating delay loop...".

when i boot the system with the "nosmp" and apic 2.0
disabled (normal apic still enabled) the system
hangs somewhere after "hda: max request size...".

the only way to get the system running is to fully
disable the apic support in the bios and run the
system with "nosmp". :-(((

additional info:
when i boot using the 2.4.26-k7-smp kernel, the system also
hangs. sometimes when saying "loading data into ramdisk.."
and sometimes later. one time a "decompression error..."
was displayed. when i boot using "nosmp", the system
boots fine. with the 2.4.26 kernel, i dont need to disable
APIC completely.

i hope that anyone could help me,
corin

