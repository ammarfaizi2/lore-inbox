Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbTBXSXa>; Mon, 24 Feb 2003 13:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbTBXSWO>; Mon, 24 Feb 2003 13:22:14 -0500
Received: from franka.aracnet.com ([216.99.193.44]:3998 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267467AbTBXSTg>; Mon, 24 Feb 2003 13:19:36 -0500
Date: Mon, 24 Feb 2003 10:29:41 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 403] New: USB controller locks up on boot.
Message-ID: <18060000.1046111381@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=403

           Summary: USB controller locks up on boot.
    Kernel Version: 2.5.62
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: davej@codemonkey.org.uk


drivers/usb/host/uhci-hcd.c: ef80: host controller halted. very bad

This appears immediately after booting. There are no USB devices plugged in.

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 04)
02:01.0 USB Controller: NEC Corporation USB (rev 41)
02:01.1 USB Controller: NEC Corporation USB (rev 41)
02:01.2 USB Controller: NEC Corporation USB 2.0 (rev 02)


