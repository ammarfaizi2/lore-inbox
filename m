Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289029AbSA0XBv>; Sun, 27 Jan 2002 18:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289039AbSA0XBb>; Sun, 27 Jan 2002 18:01:31 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:33438 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S289029AbSA0XBW>; Sun, 27 Jan 2002 18:01:22 -0500
Subject: Re: Is Local APIC work with Athlon?
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: byzantinehk@yahoo.com.hk,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200201270817.JAA27327@harpo.it.uu.se>
In-Reply-To: <200201270817.JAA27327@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 27 Jan 2002 18:01:15 -0500
Message-Id: <1012172478.17259.1.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-01-27 at 03:17, Mikael Pettersson wrote:
> On Sun, 27 Jan 2002 11:48:00 +0800 (CST), Ka Fai Lau wrote:
> >I am using ECS K7VZA (KT133a chipset) and Athlon. I
> >complied my 2.4.17 kernel with Local APIC support. How
> >do I know is it working or not? I have to use the
> >performance counter and local timer interrupt feature.
> 
> All K7s except the very first model (K7 model 1) work, unless
> your BIOS is broken. Since you have a VIA chipset, you may see
> spurious IRQ7/ERR interrupts. We don't quite know why, but it's
> not fatal. Disabling LPT support in the BIOS _may_ help.
> 
> /Mikael

This is not ENTIRELY true.  Certain hangs and crashes can be caused with
X, APM, and APIC enabled.  I haven't entirely tracked it down yet, but I
have seen it on a Thuderbird 800 (FIC SD11), an Soyo Dragon Plus (1800+
XP), and a few others.  It goes away if you turn Local APIC's off.  This
may be related to some video card issues, but I don't yet know.

Trever Adams

