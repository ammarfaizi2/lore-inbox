Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbTKAP1M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 10:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTKAP1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 10:27:12 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:37589 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263854AbTKAP1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 10:27:11 -0500
Date: Sat, 01 Nov 2003 07:27:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1469] New: (two) warnings in fs/smbfs/inode.c 
Message-ID: <1820000.1067700428@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1469

           Summary: (two) warnings in fs/smbfs/inode.c
    Kernel Version: 2.6.0-test7-bk9
            Status: NEW
          Severity: low
             Owner: bugme-janitors@lists.osdl.org
         Submitter: mitchel@sahertian.com


Distribution: Gentoo current
Hardware Environment: Linux xinu 2.6.0-test7-bk9 #1 Sat Oct 18 00:43:04 CEST
2003 i686 Intel(R) Pentium(R) 4 CPU 2.40GHz GenuineIntel GNU/Linux
Software Environment:
gcc versie 3.3.2 20031022 (Gentoo Linux 3.3.2-r2, propolice)
GNU ld version 2.14.90.0.6 20030820
as86 version: 0.16.13

Problem Description:
Compiler warnings.
  CC      fs/smbfs/inode.o
fs/smbfs/inode.c: In function `smb_fill_super':
fs/smbfs/inode.c:554: let op: comparison is always false due to limited range of
data type
fs/smbfs/inode.c:555: let op: comparison is always false due to limited range of
data type

Steps to reproduce:
`make` using my config


