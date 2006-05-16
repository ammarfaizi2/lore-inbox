Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWEPUuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWEPUuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 16:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWEPUuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 16:50:22 -0400
Received: from mail0.lsil.com ([147.145.40.20]:30950 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1750780AbWEPUuV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 16:50:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Help: strange messages from kernel on IA64 platform
Date: Tue, 16 May 2006 14:50:19 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BD84@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Help: strange messages from kernel on IA64 platform
Thread-Index: AcZ5KlclNyC/E7TaRDmsuV7b5Y2slw==
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 16 May 2006 20:50:20.0098 (UTC) FILETIME=[58240220:01C6792A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

During communication in between application and megaraid driver via
IOCTL, the system displays messages which are not easy to track down.
Following is one of the messages and same messages with different values
are poping up regularly.
---
Kernel unaligned access to 0xe00000007f3d80dc ip=0xa0000002000373b1
---

I understand the kernel is complaining about the address which is not
aligned and, found the message is coming from function
'ia64_handle_unaligned()' in the arch/ia64/kernel/unaligned.c.
But, I couldn't find who is calling this function and further details of
reasons.

Where should I start to figure out it?

Thank you,

Seokmann
