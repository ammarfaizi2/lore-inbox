Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262782AbTCVOp3>; Sat, 22 Mar 2003 09:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262784AbTCVOp3>; Sat, 22 Mar 2003 09:45:29 -0500
Received: from franka.aracnet.com ([216.99.193.44]:59603 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262782AbTCVOp1>; Sat, 22 Mar 2003 09:45:27 -0500
Date: Sat, 22 Mar 2003 06:56:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 486] New: compile failure in drivers/video/pm2fb.c
Message-ID: <354910000.1048344988@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=486

           Summary: compile failure in drivers/video/pm2fb.c
    Kernel Version: 2.5.65
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: kaas@mailbox.co.za


Distribution: mdk9.0
Hardware Environment: PIII Celeron, 256MB RAM, 
Software Environment: gcc 3.2, glibc 2.2.5, binutils-2.12.90.0.15
Problem Description: Lots of warnings and errors in drivers/video/pm2fb
Missing header files fbcon.h fbcon-cfb{8,16,24,32}.h
Too many warnings to list, see attachment
I guess the only problem is the missing header files

Steps to reproduce:CONFIG_FB_PM2=m (I guess)


