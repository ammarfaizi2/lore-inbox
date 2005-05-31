Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVEaEPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVEaEPE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 00:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVEaEPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 00:15:04 -0400
Received: from femail.waymark.net ([206.176.148.84]:57771 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S261635AbVEaEPA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 00:15:00 -0400
Date: 31 May 2005 04:05:06 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: [ACPI] 2.6.12-rc5
To: linux-kernel@vger.kernel.org
Message-ID: <e032b5.beb8a3@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Computer: Cyrix MII processor, VIA VP3 chipset  e-machines 1999
Kernels various, now 2.6.12-rc5

Observation: experimental ACPI sleep state, aka active standby,
appears to work with mainline kernels in that it's possible to
do
# echo standby > /sys/power/state
and have the system suspend. The computer's green led that's inset
into the power button blinks slowly, then. And pressing the power button
brings the system back, unless you wait too long. I'm not sure exactly
how long, but I guess it may be roughly an hour or so until linux
no longer returns when the power button is pressed briefly.

--- MultiMail/Linux v0.46
