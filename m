Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262799AbRE0QVk>; Sun, 27 May 2001 12:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262810AbRE0QVb>; Sun, 27 May 2001 12:21:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61707 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262800AbRE0QVU>; Sun, 27 May 2001 12:21:20 -0400
Subject: Re: VIA IDE no go with 2.4.5-ac1
To: green@linuxhacker.ru (Oleg Drokin)
Date: Sun, 27 May 2001 17:18:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, vojtech@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20010527144337.A15235@linuxhacker.ru> from "Oleg Drokin" at May 27, 2001 02:43:37 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1543FE-0001zX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Vanilla 2.4.5 boots ok, but 2.4.5-ac1 finishes kernel initialisation and
>   starts to print "hda: lost interrupt", I guess this is related to VIA IDE
>   updates in AC kernels. Config for vanilla and AC kernel is the same.
>   Here are the kernel logs from 2.4.5 and 2.4.5-ac1 (collected with serial

> ACPI: Core Subsystem version [20010208]
> ACPI: Subsystem enabled
> ACPI: Not using ACPI idle
> ACPI: System firmware supports: S0 S1 S4 S5
> hda: lost interrupt
> hda: lost interrupt

Does this still happen if you build without ACPI support. Also does
'noapic' have any impact ?
