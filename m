Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275720AbRJNQ0y>; Sun, 14 Oct 2001 12:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275739AbRJNQ0e>; Sun, 14 Oct 2001 12:26:34 -0400
Received: from gent-smtp1.xs4all.be ([195.144.67.21]:34313 "EHLO
	gent-smtp1.xs4all.be") by vger.kernel.org with ESMTP
	id <S275720AbRJNQ0c>; Sun, 14 Oct 2001 12:26:32 -0400
Date: Sun, 14 Oct 2001 18:27:14 +0200 (CEST)
From: frank@gevaerts.be
To: Ian Stirling <root@mauve.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA-USB interfaces for linux?
In-Reply-To: <200110141505.QAA11568@mauve.demon.co.uk>
Message-ID: <Pine.LNX.4.21.0110141824290.11813-100000@turing.gevaerts.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2001, Ian Stirling wrote:

> Are there any PCMCIA(not cardbus)-usb interfaces around, usable by linux,
> for those of us with older laptops?

I wouldn't count on it. The 'normal' USB controller (uhci,ohci,ehci(usb
2.0)) specs are defined in terms of PCI accesses. PCMCIA means no PCI, so
even if such a card exists, I think it is very unlikely to work with
(semi)standard drivers.
However, someone on this list once mentinned he had an ISA USB adapter, so
you never know.

Frank

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

HI! I'm a .signature virus! cp me into your .signature file to help me spread!

