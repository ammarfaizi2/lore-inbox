Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261598AbTCURUY>; Fri, 21 Mar 2003 12:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262578AbTCURUY>; Fri, 21 Mar 2003 12:20:24 -0500
Received: from hexagon.stack.nl ([131.155.140.144]:54032 "EHLO
	hexagon.stack.nl") by vger.kernel.org with ESMTP id <S261598AbTCURUX>;
	Fri, 21 Mar 2003 12:20:23 -0500
Date: Fri, 21 Mar 2003 18:31:24 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.65: 3C905 driver doesn't work.
In-Reply-To: <20030321153704.GA3762@suse.de>
Message-ID: <20030321182933.E11076-100000@snail.stack.nl>
References: <200303211618.36485.josh@stack.nl> <20030321153704.GA3762@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Mar 2003, Dave Jones wrote:

> On Fri, Mar 21, 2003 at 04:18:36PM +0100, Jos Hulzink wrote:
>
>  > 2.5.65 doesn't connect to my network via my network card:
>  >
>  > 00:0b.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
>  >
>  > My switch does show a link, but the dhcpcd negotiation fails, and no activity
>  > is shown.
>  >
>  > All kernel logs look normal, no errors, card is detected correctly.
>
> try booting with..
> "acpi=off"
> "noapic"
> "acpi=off noapic"
>
> For me, the third one gets it working again on two boxes.
> Without that, packets are sent, but nothing is ever recieved.
>

For me, the third option results in a kernel panic very early during boot
:( I'm trying to get more info out of it.

Other options untested yet.

Jos
