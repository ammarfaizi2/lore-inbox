Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUDEIwI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 04:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUDEIwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 04:52:08 -0400
Received: from ont-DSL172-cust055.mpowercom.net ([208.57.172.55]:14607 "EHLO
	btfh.net") by vger.kernel.org with ESMTP id S261822AbUDEIwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 04:52:06 -0400
Message-ID: <000501c41aeb$46f20780$eb0aa8c0@bofh>
From: "Support" <Support@btfh.net>
To: <linux-kernel@vger.kernel.org>
Cc: <andrew.grover@intel.com>, <paul.s.diefenbaugh@intel.com>
Subject: possible bug in the acpi_bus.h file in kernel 2.4.25
Date: Mon, 5 Apr 2004 02:52:06 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Authenticated-Sender: Support@btfh.net
X-Spam-Processed: btfh.net, Mon, 05 Apr 2004 01:52:03 -0700
	(not processed: spam filter disabled)
X-MDRemoteIP: 216.17.172.80
X-Return-Path: Support@btfh.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: btfh.net, Mon, 05 Apr 2004 01:52:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in the acpi_bus.h file, there is a reference to  device.h, however no such
file exists in the 2.4.25 source code and causes a compile error when
including acpi in the compile.

the line is as follows


#include <linux/device.h>


