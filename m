Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVCEUqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVCEUqH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVCEUl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 15:41:28 -0500
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.201]:5509 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261215AbVCEUhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 15:37:23 -0500
Date: Sat, 05 Mar 2005 13:25:02 -0500 (EST)
From: vcjones@networkingunlimited.com (Vincent C Jones)
Subject: APM vs. USB BlueTooth in 2.6.11
To: linux-kernel@vger.kernel.org
Message-id: <20050305182502.53B21224E6@X31.networkingunlimited.com>
Organization: Networking Unlimited, Inc.
Content-transfer-encoding: 7BIT
Newsgroups: linux.kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SuSE 9.2 on IBM ThinkPad X31 (2884-JUU), 2.6.11 kernel. Great having a
notebook where everything just works.

Bluetooth (hci_usb) works fine, but after suspend/resume cycle using
APM the BlueTooth interface dies (LED goes out) and I can't get it back
by unloading/reloading modules. However, if I compile the bluetooth and
hci_usb into the kernel rather than as modules, suspend resume seems to
work fine. (APM is configured to stop/start Bluetooth service around a
suspend/resume cycle).

Any idea why?

FWIW: I still use APM because ACPI suspend to RAM consumes 1250
mW/hour while APM suspend to RAM is only 360 mW/hour, not worth the
fancy features, but that is another topic. Windows XP ACPI suspend
to RAM consumes 525 mW/hour. 

Any suggestions on how to reduce power consumption when suspended
using ACPI?

-- 
Dr. Vincent C. Jones, PE              Expert advice and a helping hand
Computer Network Consultant           for those who want to manage and
Networking Unlimited, Inc.            control their networking destiny
Phone: +1 201 568-7810
14 Dogwood Lane, Tenafly, NJ 07670
VCJones@NetworkingUnlimited.com     http://www.networkingunlimited.com
