Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbTADT2q>; Sat, 4 Jan 2003 14:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbTADT2q>; Sat, 4 Jan 2003 14:28:46 -0500
Received: from [81.2.122.30] ([81.2.122.30]:23559 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261330AbTADT2p>;
	Sat, 4 Jan 2003 14:28:45 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301041937.h04Jb6gX002589@darkstar.example.net>
Subject: Re: RH73 Promise ATA/133 Install Problems
To: rbroman@bayarea.net (Randy Broman)
Date: Sat, 4 Jan 2003 19:37:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, rbroman@bayarea.net, alan@redhat.com
In-Reply-To: <3E173679.6050807@bayarea.net> from "Randy Broman" at Jan 04, 2003 11:31:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>I have a  Gigabyte GA-7VRXP motherboard which has an on-board
> >>Promise 20276 ATA133/RAID controller. I want to install RH73, on the
> >>two ATA133 drives connected to the Promise controller. I've set up
> >>the motherboard BIOS with the Promise 20276 interfaces as ATA (not
> >>RAID), and I want to install on the two drives in a software RAID
> >>configuration.
> >>
> >>If I start the standard RH73 install it does not identify the two drives 
> >>connected to the Promise interfaces.
> >>
> >
> >Support for the Promise 20276 went in to the kernel at 2.4.19-pre6.
> >
> >Can you get to a command prompt and post the output of lspci -v -v?
> >Maybe it has a non standard PCI id and is not being recognised.

> # lspci -v -v
> 
> 00:0f.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 
> 01) (prog-if 85)
> Subsystem: Giga-byte Technology: Unknown device b001

That might be the problem.  If that ID is added to the correct list it
may well work.

John.
