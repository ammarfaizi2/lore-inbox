Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbTADSvS>; Sat, 4 Jan 2003 13:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbTADSvS>; Sat, 4 Jan 2003 13:51:18 -0500
Received: from [81.2.122.30] ([81.2.122.30]:64006 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261317AbTADSvR>;
	Sat, 4 Jan 2003 13:51:17 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301041859.h04IxaGQ002334@darkstar.example.net>
Subject: Re: RH73 Promise ATA/133 Install Problems
To: rbroman@bayarea.net (Randy Broman)
Date: Sat, 4 Jan 2003 18:59:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E172D5B.70402@bayarea.net> from "Randy Broman" at Jan 04, 2003 10:52:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a  Gigabyte GA-7VRXP motherboard which has an on-board
> Promise 20276 ATA133/RAID controller. I want to install RH73, on the
> two ATA133 drives connected to the Promise controller. I've set up
> the motherboard BIOS with the Promise 20276 interfaces as ATA (not
> RAID), and I want to install on the two drives in a software RAID
> configuration.
> 
> If I start the standard RH73 install it does not identify the two drives 
> connected to the Promise interfaces.

Support for the Promise 20276 went in to the kernel at 2.4.19-pre6.

Can you get to a command prompt and post the output of lspci -v -v?
Maybe it has a non standard PCI id and is not being recognised.

John.
