Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131014AbQKBODd>; Thu, 2 Nov 2000 09:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131394AbQKBODW>; Thu, 2 Nov 2000 09:03:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:39940 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131014AbQKBODL>; Thu, 2 Nov 2000 09:03:11 -0500
Date: Thu, 2 Nov 2000 09:02:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: kernel@kvack.org
cc: "Dr. David Gilbert" <dg@px.uk.com>, linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
In-Reply-To: <Pine.LNX.3.96.1001102085215.13796A-100000@kanga.kvack.org>
Message-ID: <Pine.LNX.3.95.1001102090044.8621A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000 kernel@kvack.org wrote:

> On Thu, 2 Nov 2000, Dr. David Gilbert wrote:
> 
> > I've included /proc/pci, /proc/interrupt /proc/cpuinfo and the kernel
> > config (2.4.0-test10).
> 
> > CONFIG_MTRR=y
> 
> I bet it's the mtrr bugs.  Take a look in /proc/mtrr.  Someone suggested
> that if you disable the cachable settings in the BIOS for the BIOS/VGA/ROM
> regions, the bug can be avoided.
> 
> 		-ben

Yes. Look at the NMI count. Looks like every access produces a
NMI.

Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
