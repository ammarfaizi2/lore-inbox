Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbTB0Uzz>; Thu, 27 Feb 2003 15:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbTB0Uzz>; Thu, 27 Feb 2003 15:55:55 -0500
Received: from web20709.mail.yahoo.com ([216.136.226.182]:25725 "HELO
	web20709.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266135AbTB0Uzy>; Thu, 27 Feb 2003 15:55:54 -0500
Message-ID: <20030227210613.17243.qmail@web20709.mail.yahoo.com>
Date: Thu, 27 Feb 2003 13:06:13 -0800 (PST)
From: Paul Adams <padamsdev@yahoo.com>
Subject: PCI bridge disconnects and retries
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a DMA Bus Master device on a PCI-X or PCI 64/66
bus under Linux/x86 (UP and SMP).  The device is
capable of long bursts without wait states, but the
various host-PCI bridges I have tried will disconnect
after very short bursts or will require many retries
before starting a burst.  I would be interested in any
suggestions for configuring the CPU cache or the
bridge or ways to tune the behavior of the device to
optimize sustained throughput.  I am looking at a
number of standard chipsets such as Serverworks Grand
Champion, Intel E7500, and AMD-760 MPX.  For example,
how can the prefetch behavior on each of these bridges
be tuned?  Are specs available for any of the bridges?
 Can the driver do anything to make better use of
caches and prefetching?

Paul Adams




__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/
