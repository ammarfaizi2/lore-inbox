Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131283AbQKPS3x>; Thu, 16 Nov 2000 13:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131166AbQKPS3m>; Thu, 16 Nov 2000 13:29:42 -0500
Received: from mail.inconnect.com ([209.140.64.7]:45189 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S131178AbQKPS3a>; Thu, 16 Nov 2000 13:29:30 -0500
Date: Thu, 16 Nov 2000 10:59:27 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: APM oops with Dell 5000e laptop
In-Reply-To: <E13wRYd-0007yS-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.30.0011161054420.16124-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox said once upon a time (Thu, 16 Nov 2000):

> > I just got a Sceptre 6950 (also known as a Dell 5000e), I just installed
> > Red Hat 7.0 on it, and got an APM related oops at boot.
>
> Yep. This is not a Linux problem

The kernel works around/ignores/disables other broken hardware or broken
features of otherwise working hardware with black lists.  There will be
many *many* of these laptops sold.

Is there a way to uniquely identify the affected BIOSes at boot time and
turn off APM?  According to Brad Douglas, the 32-bit Get Power Status
(0AH) call is broken.

Supposedly there will be a BIOS update in the "future" to correct this
problem.

Dax

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
