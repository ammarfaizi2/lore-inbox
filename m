Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263658AbTE0Ovr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbTE0Ovr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:51:47 -0400
Received: from nelson.SEDSystems.ca ([192.107.131.136]:61902 "EHLO
	nelson.sedsystems.ca") by vger.kernel.org with ESMTP
	id S263658AbTE0Ovl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:51:41 -0400
Date: Tue, 27 May 2003 09:04:46 -0600 (CST)
From: Kendrick Hamilton <hamilton@sedsystems.ca>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Getting APIC interrupts
Message-ID: <Pine.LNX.4.44.0305270857580.14661-100000@sw-55.sedsystems.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	please CC hamilton@sedsystems.ca with responses/dicsussion 
regarding this posting.

	We developped a modulator card and device driver for linux. The 
card is a PCI card. When installed in an IBM E-server, dual processor xeon 
computer, the linux kernel does not receive any interupts. If I cat 
/proc/interrupts, the card is assigned interrupt 10 on the XT-PIC. The 
only other device assigned to the XT-PIC is cascade. When we check the 
card's intterupt line with an oscilloscope, we see that an interrupt is 
being generated.
	A temporary work around is to use the noapic flag with the kernel. 
I am wondering if there is a special call when requesting the interrupt 
that I can use to get the interrupt to go through the APIC so I don't need 
the noapic flag?


-- 
Kendrick Hamilton E.I.T.
SED Systems, a division of Calian Ltd.
18 Innovation Blvd.
PO Box 1464
Saskatoon, Saskatchewan
Canada
S7N 3R1

Hamilton@sedsystems.ca
Tel: (306) 933-1453
Fax: (306) 933-1486

