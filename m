Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264865AbRGEIni>; Thu, 5 Jul 2001 04:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266666AbRGEIn2>; Thu, 5 Jul 2001 04:43:28 -0400
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:38900 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id <S264865AbRGEInT>; Thu, 5 Jul 2001 04:43:19 -0400
Date: Thu, 5 Jul 2001 10:43:23 +0200
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What are rules for acpi_ex_enter_interpreter?
Message-ID: <20010705104323.C711@c239-1.fem.tu-ilmenau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi,

i'm not on the linux-kernel@ list, so the references are
broken, sorry for that :)

You wrote:
> On Wed, Jul 04, 2001 at 03:38:07AM +0200, Petr Vandrovec wrote:
> Replying to myself, after following change in additon to acpi_ex_...
> poweroff on my machine works. It should probably map type 0 => 0, 3 => 1
> and 7 => 2, but it is hard to decide without VIA datasheet, so change
> below is minimal change needed to get poweroff through ACPI to work on
> my ASUS A7V.
> diff -urdN linux/drivers/acpi/hardware/hwsleep.c
> > diff -urdN linux/drivers/acpi/namespace/nsinit.c

Yeah, this fixes the ACPI Power off "Cannot enter S5" problem
on my ASUS CUV4X-D too.

Of course, I applied the patch without the memcmp()s :)


regards,
   Mario
-- 
Mario 'BitKoenig' Holbe <Mario.Holbe@RZ.TU-Ilmenau.DE>

So long and thanks for all the books.
