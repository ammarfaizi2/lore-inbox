Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270638AbTGNPf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270646AbTGNPf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:35:57 -0400
Received: from franka.aracnet.com ([216.99.193.44]:38374 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S270638AbTGNPfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:35:46 -0400
Date: Mon, 14 Jul 2003 08:50:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 921] New: PPC still has uptime readings of 12000+ days 
Message-ID: <219140000.1058197821@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=921

           Summary: PPC still has uptime readings of 12000+ days
    Kernel Version: 2.5.75 (2.5.75-bkX and 2.6.0-test1 don't compile due to
                    bug 919)
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: barryn@pobox.com


Distribution: Gentoo
Hardware Environment: Apple PowerMac G4, 400MHz, AGP Graphics
Software Environment: gcc 2.95.3
Problem Description: Uptime is listed as a seriously trippy/bogus 12247 days and
counting...

Example:
barryn@barryn barryn $ uname -a
Linux barryn 2.5.75 #1 Mon Jul 14 07:39:20 PDT 2003 ppc  7400, altivec supported
GNU/Linux
barryn@barryn barryn $ uptime
 07:57:06  up 12247 days, 14:57,  7 users,  load average: 0.17, 0.08, 0.05

Steps to reproduce:
Just boot and run "uptime".


