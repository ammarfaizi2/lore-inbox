Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317819AbSGKMEv>; Thu, 11 Jul 2002 08:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317820AbSGKMEu>; Thu, 11 Jul 2002 08:04:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30216 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317819AbSGKMEu>; Thu, 11 Jul 2002 08:04:50 -0400
Subject: Re: HZ, preferably as small as possible
To: kasperd@daimi.au.dk (Kasper Dupont)
Date: Thu, 11 Jul 2002 13:30:06 +0100 (BST)
Cc: ltd@cisco.com (Lincoln Dale), linux-kernel@vger.kernel.org (Linux)
In-Reply-To: <3D2D6D9C.CA7A17FC@daimi.au.dk> from "Kasper Dupont" at Jul 11, 2002 01:35:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Sd5D-0000lz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like to see oneshot timer interrupts as a compile time
> option on any architecture that is capable of doing it. But of
> course it is not easy.
> 
> Have I missed something somewhere?

The APIC on modern systems has decent timers. There may also be ACPI timers
we can use on ACPI capable systems.
