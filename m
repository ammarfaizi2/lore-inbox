Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbTIMOhJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 10:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbTIMOhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 10:37:09 -0400
Received: from [208.191.98.137] ([208.191.98.137]:65428 "EHLO xorgate.com")
	by vger.kernel.org with ESMTP id S262155AbTIMOhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 10:37:08 -0400
Message-ID: <000501c37a0c$e2ad24a0$3eac18ac@geosxp>
From: "George" <george@xorgate.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6 kernel large file create problem
Date: Sat, 13 Sep 2003 09:37:05 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 300G reiserfs 3.6 file system created above a RAID0 (HPT372
controller) partition.  When I am using the 2.6.0-test5 kernel and create
files larger that 4GB they are corrupted with lots of trash throughout the
file.  When I use the same file system with the 2.4.22 kernel it works fine.

