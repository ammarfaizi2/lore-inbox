Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbRGJP5C>; Tue, 10 Jul 2001 11:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266629AbRGJP4w>; Tue, 10 Jul 2001 11:56:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:65408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266622AbRGJP4d>; Tue, 10 Jul 2001 11:56:33 -0400
Date: Tue, 10 Jul 2001 11:56:11 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: John Clemens <john@deater.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: BIOS, Duron4 specifics...
In-Reply-To: <Pine.LNX.4.33.0107101121100.13575-100000@pianoman.cluster.toy>
Message-ID: <Pine.LNX.3.95.1010710115050.16575C-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, John Clemens wrote:

> 
> Sorry if this is a little offtopic but I'm stumped...
>
[SNIPPED...] 
> Nowhere does it appear to enable SSE or the APIC.  Is there anyway I can
> get at least UP-APIC working without BIOS help?  I really don't like
> having 4 things on IRQ11... and how about SSE (fully realizing i'd have
         ^^^^^^^^^^^^^^^^^

I think you will find that this is a problem with the basic design,
not the APIC. Just like my COMPAQ Presario 1800, everything on the
PCI bus shares the same interrupt.

You can recompile the kernel for SMP. This will guarantee that
the kernel initializes the APIC (at least up to version 2.4.1).

If you find that everything is still on the same IRQ, that's the
way it is, only one PWB trace going to the devices.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


