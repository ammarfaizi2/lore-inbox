Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbVJKWJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbVJKWJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 18:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVJKWJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 18:09:32 -0400
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:8543 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1751011AbVJKWJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 18:09:31 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: <linux-kernel@vger.kernel.org>
Subject: AIC79xx fails built into kernel, but works as a module
Date: Tue, 11 Oct 2005 17:14:43 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcXOsS4dQenICsIJSniOppNw8xVnIA==
Message-ID: <EXCHG2003c0D543Tuyl00000f37@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 11 Oct 2005 22:05:10.0324 (UTC) FILETIME=[D8E25F40:01C5CEAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a 2.6.13 kernel and if the aic79xx driver is built into
the kernel it gives odd scsi errors (similar to what you would
get with a bad cable).     With the same thing build as a module
all appears to be fine, and the disk appears to function correctly.

Is this a known behavior?   The kernel has very few things build
it, the only one that could be an issue is a Sata Sil driver to
support a SIL 3114 chip with disks on it.

I am going to do some more testing on it to verify exactly what
I see.

                             Roger

