Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265998AbUBJQcl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUBJQck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:32:40 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:27910 "EHLO
	mwinf0102.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265998AbUBJQce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:32:34 -0500
Date: Tue, 10 Feb 2004 17:32:32 +0100
From: Lucas Nussbaum <lucas@lucas-nussbaum.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.3-rc2 fails to boot with "Illegal Instruction" on sparc64
Message-ID: <20040210163232.GA2107@blop.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Lacking
X-PGP: http://www.lucas-nussbaum.net/pubkey.txt
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please Cc me as I'm not subscribed to the list ]

Hi,

Linux 2.6.3-rc2 fails to boot on sparc64. 2.6.2 doesn't boot neither.

The output is :
Allocated 8 Megs of memory at 0x4000000 for kernel

Loaded kernel version 2.6.3    <--- SILO message
Illegal Instruction
{0} ok 

2.6.1 boots without any problem. 
silo v. 1.4.4

We used gcc 3.3 to compile the kernel. Same issue with gcc 3.2.
2.6.1 compiled with exactly the same build environment does boot.

The box is a Sun Entreprise 4000.
/proc/cpuinfo:
cpu             : TI UltraSparc I   (SpitFire)
fpu             : UltraSparc I integrated FPU
promlib         : Version 3 Revision 2
prom            : 3.2.4
type            : sun4u
ncpus probed    : 4
ncpus active    : 4
Cpu0Bogo        : 333.41
Cpu0ClkTck      : 0000000009f437c0
Cpu1Bogo        : 333.41
Cpu1ClkTck      : 0000000009f437c0
Cpu4Bogo        : 333.41
Cpu4ClkTck      : 0000000009f437c0
Cpu5Bogo        : 333.41
Cpu5ClkTck      : 0000000009f437c0
MMU Type        : Spitfire
State:
CPU0:           online
CPU1:           online
CPU4:           online
CPU5:           online

Any clues ?
Any other useful information I could provide ?
-- 
Lucas Nussbaum
Club GNU/Linux
ENSIMAG - Departement Telecommunications
