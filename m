Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271817AbTG2OSV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271818AbTG2OSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:18:21 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:32667 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S271817AbTG2OSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:18:06 -0400
Date: Tue, 29 Jul 2003 07:17:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1009] New: Startup hangs with SiI 3112 driver compiled in for some time
Message-ID: <2930000.1059488266@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1009

           Summary: Startup hangs with SiI 3112 driver compiled in for some
                    time
    Kernel Version: 2.6.0-test2
            Status: NEW
          Severity: normal
             Owner: bzolnier@elka.pw.edu.pl
         Submitter: felix.seeger@gmx.de


Distribution: Debian unstable 
Hardware Environment: Asus A7N8X Deluxe (Nforce2) with SiI 3112 
Software Environment: plain 2.6.0-test2, gcc 3.3.1 
Problem Description: 
The driver for my SATA chip need some minutes at bootup because I don't have any devices 
connected to it. It probes for disks with an timeout 3 times per disk (if I am right) 
It takes way to long to startup with an SiI 3112 driver enabled kernel, but without disks 
connected to it. 
 
Steps to reproduce: 
Build the SiI 3112 driver into the kernel 
Remove both disks from the controller 
Startup and wait


