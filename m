Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267008AbTGGNns (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 09:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267017AbTGGNnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 09:43:47 -0400
Received: from franka.aracnet.com ([216.99.193.44]:942 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S267008AbTGGNnj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 09:43:39 -0400
Date: Mon, 07 Jul 2003 06:57:57 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 882] New: R31 loops under suspend mode (hard disk password mode)
Message-ID: <9170000.1057586277@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=882

           Summary: R31 loops under suspend mode (hard disk password mode)
    Kernel Version: 2.5.74
            Status: NEW
          Severity: high
             Owner: apmbugs@rothwell.emu.id.au
         Submitter: dave@nullcube.com


Distribution: Debian Woody Unstable
Hardware Environment: IBM Thinkpad R31
Software Environment: Debian Linux
Problem Description: When placing laptop into suspend mode laptop successfully
enters suspend.  However on returning from suspend laptop laptop (as configured
to) requests
hard disk power up password, when password is entered, laptop immediately
resumes the suspend mode.  This happens indefinitely until forced to hard boot
laptop.

Steps to reproduce:
- Set BIOS to request hard disk powerup password
- Compile kernel for APM PowerOff option
- Once booted under new kernel, place laptop into suspend mode either by closing
lid, or using suspend keys
- Laptop will then begin to display behaviour when brought out of suspend mode.


