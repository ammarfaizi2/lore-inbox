Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSGEDsC>; Thu, 4 Jul 2002 23:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSGEDsB>; Thu, 4 Jul 2002 23:48:01 -0400
Received: from pool-151-197-240-173.phil.east.verizon.net ([151.197.240.173]:6528
	"EHLO porsche.genebrew.com") by vger.kernel.org with ESMTP
	id <S315275AbSGEDsA>; Thu, 4 Jul 2002 23:48:00 -0400
Message-ID: <000d01c223d7$bda9ae30$0301a8c0@genebrew.com>
From: "Rahul Karnik" <rahul@genebrew.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/27] Fix 3c59x driver for some 3c566B's
Date: Thu, 4 Jul 2002 23:55:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Fix from Rahul Karnik and Donald Becker - some new 3c566B mini-PCI NICs
> refuse to power up the transceiver unless we tickle an undocumented bit
> in an undocumented register.  They worked this out by before-and-after
> diffing of the register contents when it was set up by the Windows
> driver.

Just to clarify -- Dave Dribin did the actual capturing of the EEPROM
contents; Donald Becker posted the code to implement the fix; and I simply
adapted the fix to the in-kernel driver.

Thanks,
Rahul

