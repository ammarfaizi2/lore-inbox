Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbUKMPd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbUKMPd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 10:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbUKMPd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 10:33:58 -0500
Received: from vsmtp1.tin.it ([212.216.176.141]:48264 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S262763AbUKMPd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 10:33:56 -0500
Subject: Strange hang at init, kernel bug?
From: Mario Giammarco <mgiammarco@virgilio.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 13 Nov 2004 16:33:57 +0100
Message-Id: <1100360037.8303.7.camel@r50p>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I have this situation:
 
 computer A: ahtlon 1600 with fibre channel hard disks connected with
mpt fusion controller.
 
 computer B: dual pentium III with ide software raid.
 
 in computer A hard disks have unused partitions, so I connected
computer B to fc hard disks in A with another mpt fusion controller.
 
 I have tried with kernel 2.6.8-2.6.9 with/without kolivas, smp and
nosmp, etc.



 I have tried also raid/noraid smp/nosmp 

 I use debian/unstable, tried with different "init" packages.
 
 I copy using computer B the ide raid contents in fc hard disks (cp -a)
all ok without errors, I check filesystems: no errors.
 
 Now I reboot computer B from fibre hard disk and it hangs just after
init:
 
 I have tried with several file systems:
 
 - with reiser it says filesystem corrupted
 - with jfs it hangs with "respawning too fast"
 - with xfs it hangs with init: segmentation violation
 
 I boot the same partition with computer A and it works...
 
 I am desperate, what can I do?
 
 Thanks in advance for any reply!

