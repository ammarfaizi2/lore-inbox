Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbTBTKW5>; Thu, 20 Feb 2003 05:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbTBTKW4>; Thu, 20 Feb 2003 05:22:56 -0500
Received: from [202.41.99.9] ([202.41.99.9]:43200 "EHLO
	mail-relay-vsat2.ernet.in") by vger.kernel.org with ESMTP
	id <S265132AbTBTKW4>; Thu, 20 Feb 2003 05:22:56 -0500
Date: Thu, 20 Feb 2003 16:10:03 +0500 (GMT)
From: Sahani Himanshu <honeyuee@iitr.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: Adaptec drivers causing problem in RHL 8.0
In-Reply-To: <20030220083620.31336.qmail@linuxmail.org>
Message-ID: <Pine.GSO.4.05.10302201550440.2763-100000@iitr.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

May be you will say that this has been answered somewhere, but I am not
really able to understand what to do?

I recently installed RHL 8.0 on a SGI1200 server. The server has 
"Adaptec AIC-7896 SCSI BIOS v2.20S1B1" installed.

When I boot the system, the two SCSI channels are recognised, and then the
system is not able to initialise. The partial error codes are:

aic7xxx_abort returns 0x2002
SCSI 0:0:0:0: Attempting to queue TARGET RESET message
SCSI 0:0:0:0: Is not an active device

The system then probes the SCSI 0:0:1:0 channel upto SCSI 0:0:15:0 and
then goes for SCSI channel 2, for all the 15 devices.

Can anyone please tell me what should I do? The system was earlier running
on RHL 6.2

Thanx in advance.
With Best Regards
HimS

