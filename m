Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbTAVKc6>; Wed, 22 Jan 2003 05:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267421AbTAVKc6>; Wed, 22 Jan 2003 05:32:58 -0500
Received: from [81.2.122.30] ([81.2.122.30]:36868 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267418AbTAVKc5>;
	Wed, 22 Jan 2003 05:32:57 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301221042.h0MAgQjK000389@darkstar.example.net>
Subject: Re: Bad TCP checksums - can you solve the puzzle?
To: 21442@gmx.net (Matjaz Omerzel)
Date: Wed, 22 Jan 2003 10:42:26 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E2E6D84.8D485EF3@gmx.net> from "Matjaz Omerzel" at Jan 22, 2003 11:08:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Network card is verified and working. IP checksums never fail (0 packets
> lost after two days of flood ping). TCP works with same kernel, same NIC
> but on a different machine (Athlon 950) as well as with same machine,
> same NIC and Windows 98. Needless to say, it works with different
> machine (PIII) and different OS (Win2k).
> 
> Machine is verified, it has been working reliably for years. If, instead
> of Tornado, I use a 3Com 3C509B (10Mbit EISA), the TCP works perfectly.
> But if Tornado card was defective, TCP should also work with Via Rhine
> (DFE-530TX) - but it DOESN'T. (However, drivers via-rhine and 3c59x I
> believe were made by the same author, just in case that makes any sense)

Is the bus speed of the 486, and the other machine you tested the
3x905C-TX in the same?  The 486 sounds like it has EISA and PCI busses
- are you sure that the PCI bus is set to the correct clock speed?

John.
