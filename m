Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVJBIOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVJBIOi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 04:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbVJBIOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 04:14:38 -0400
Received: from news.cistron.nl ([62.216.30.38]:35238 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S1751014AbVJBIOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 04:14:37 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: report: 2.6.14-rc2-git8 crashed with scsi error after 40 hours
Date: Sun, 2 Oct 2005 08:14:36 +0000 (UTC)
Organization: Cistron
Message-ID: <dho4tc$ilc$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1128240876 19116 62.216.30.70 (2 Oct 2005 08:14:36 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the more than weekly error report about our usenetgateway.
2.6.12-mm1 keeps running for weeks.
2.6.1[34] keeps crashing within days
Hardware isn't the problem, software is (my guess is acpi/irq)
ethernet is doing >200megabit/s average on 2 cards simultanious.

hardware:
tyan amd64 - opteron 250 (dual cpu, but UP kernel)
4Gig ram
dual scsi controller
8 x scsi disks
acenic gig-E (FO)
onboard gig-E (cupper)

software:
debian-pure64 amd


config/crash/dmesg @
http://newsgate.newsserver.nl/kernel/2.6.14-rc2-git8

Currently trying 2.6.14-rc2-mm2.
When that fails i will try rc3-git[latest]

Let me know when someone wants to have more info or a test
setup.

Danny

