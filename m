Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292978AbSB0Vmd>; Wed, 27 Feb 2002 16:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292973AbSB0Vlc>; Wed, 27 Feb 2002 16:41:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7697 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292972AbSB0Vio>; Wed, 27 Feb 2002 16:38:44 -0500
Subject: Re: Dual P4 Xeon i860 system - lockups in 2.4 & no boot in 2.2
To: texas@ludd.luth.se (texas)
Date: Wed, 27 Feb 2002 21:53:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSU.4.33.0202272221050.23720-100000@father.ludd.luth.se> from "texas" at Feb 27, 2002 10:23:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gC11-0005zS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is now enabled together with the acpismp=force in lilo. Note however
> that the "WARNING: No sibling found" messages are still there. Strange?

Means it isnt find the HT tables

> The new boot messages, with acpismp=force and HT enabled in BIOS, note new
> ACPI messages, like "Searched entire block, no RSDP was found". Problem?

It couldnt find an ACPI table - The hyperthreading data is described in
the ACPI tables in the BIOS. Without them we can't do much with it

HT tends to be worth 20% performance so its worth finding out why 8)
