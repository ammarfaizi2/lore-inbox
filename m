Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136619AbREAPHI>; Tue, 1 May 2001 11:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136629AbREAPG5>; Tue, 1 May 2001 11:06:57 -0400
Received: from jalon.able.es ([212.97.163.2]:65251 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S136630AbREAPGk>;
	Tue, 1 May 2001 11:06:40 -0400
Date: Tue, 1 May 2001 17:06:32 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac2
Message-ID: <20010501170632.A1057@werewolf.able.es>
In-Reply-To: <E14uXjN-0001UN-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14uXjN-0001UN-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, May 01, 2001 at 12:50:07 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05.01 Alan Cox wrote:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 

Hangs after APIC init:

(bootlog from ac1)
Using local APIC timer interrupts.
calibrating APIC timer ...
.... CPU clock speed is 400.9211 MHz.
.... host bus clock speed is 100.2300 MHz.
cpu: 0, clocks: 1002300, slice: 334100
CPU0<T0:1002288,T1:668176,D:12,S:334100,C:1002300>
cpu: 1, clocks: 1002300, slice: 334100
CPU1<T0:1002288,T1:334080,D:8,S:334100,C:1002300>
checking TSC synchronization across CPUs: passed.

<ac2 stops here>

PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware

Now I am going to spread printk's over the source, and set APIC_DEBUG=1,
but if someone has a clue ?
Ask for more info if it can be useful...

--
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.4-ac1 #1 SMP Tue May 1 11:35:17 CEST 2001 i686

