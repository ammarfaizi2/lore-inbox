Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317849AbSGKPUw>; Thu, 11 Jul 2002 11:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317850AbSGKPUv>; Thu, 11 Jul 2002 11:20:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47881 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317849AbSGKPUu>; Thu, 11 Jul 2002 11:20:50 -0400
Subject: Re: HZ, preferably as small as possible
To: kasperd@daimi.au.dk (Kasper Dupont)
Date: Thu, 11 Jul 2002 16:46:35 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ltd@cisco.com (Lincoln Dale),
       linux-kernel@vger.kernel.org (Linux)
In-Reply-To: <3D2D8A35.30F460F3@daimi.au.dk> from "Kasper Dupont" at Jul 11, 2002 03:37:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Sg9L-00012G-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The APIC on modern systems has decent timers. There may also be ACPI timers
> > we can use on ACPI capable systems.
> 
> In what units do they meassure time? It would be nice if
> they were garanteed to match the TSC frequency or some
> other of the units already being used.

It really doesn't matter providing the resolution is decent. Conversion 
between formats of time is a maths operation, and we can handle those 8)
