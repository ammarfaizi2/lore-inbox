Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTFIOZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTFIOZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:25:53 -0400
Received: from franka.aracnet.com ([216.99.193.44]:34527 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264372AbTFIOZA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:25:00 -0400
Date: Mon, 09 Jun 2003 07:38:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 791] New: motorola sandpoint code does not compile
Message-ID: <39560000.1055169517@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: motorola sandpoint code does not compile
    Kernel Version: 2.5.70
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: thomas@koeller.dyndns.org


Distribution: none 
Hardware Environment: Motorola Sandpoint X3 /w Unity/8240 MPPMC 
Software Environment: Cross build on Linux/x86 host using gcc-3.3 
Problem Description: arch/ppc/platforms/sandpoint_setup.c does not compile because 
the call to openpic_init() in line #309 does not match the punction prototype as defined 
in include/asm-ppc/open_pic.h 
 
Steps to reproduce: Configure for Sandpoint X3 target and build.


