Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUCVCll (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 21:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUCVCll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 21:41:41 -0500
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:27803
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261635AbUCVClk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 21:41:40 -0500
From: "Shawn Starr" <shawn.starr@rogers.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PANIC][2.6.5-rc2-bk1] st_probe - Detection of a SCSI tape drive (HP Colorado T4000s)
Date: Sun, 21 Mar 2004 21:44:55 -0500
Message-ID: <000001c40fb7$a909f390$030aa8c0@PANIC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [67.60.40.239] using ID <shawn.starr@rogers.com> at Sun, 21 Mar 2004 21:40:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apon booting 2.6.5-rc2-bk1, during detection of the SCSI tape drive, the
kernel panics

The backtrace is:

st_probe
__lockup_hash
dput
sysfs_create_dir
bus_match
driver_match
kobject_register
bus_add_driver
driver_register
init_st
do_initcalls
init
init
kernel_thread_helper

Is this known? I will revert to my previous kernel 

Shawn.


