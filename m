Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130642AbQLHKRR>; Fri, 8 Dec 2000 05:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131283AbQLHKQ5>; Fri, 8 Dec 2000 05:16:57 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:4602 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S130642AbQLHKQs>;
	Fri, 8 Dec 2000 05:16:48 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20001208022044.A6417@gruyere.muc.suse.de> 
In-Reply-To: <20001208022044.A6417@gruyere.muc.suse.de>  <E144BOL-0003Eg-00@the-village.bc.nu> <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com> 
To: Andi Kleen <ak@suse.de>
Cc: Rainer Mager <rmager@vgkk.com>, linux-kernel@vger.kernel.org,
        Mark Vojkovich <mvojkovich@valinux.com>
Subject: Re: Signal 11 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Date: Fri, 08 Dec 2000 09:46:07 +0000
Message-ID: <25692.976268767@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ak@suse.de said:
>  Sounds like a X Server bug. You should probably contact XFree86, not
> linux-kernel

I quote from the X devel list, which perhaps I shouldn't do but this is hardly 
NDA'd stuff:

On Mon 20 Nov 2000, mvojkovich@valinux.com said:
>   I have seen random crashes on dual P3 BX boards (Tyan) and dual Xeon
> GX boards (Intel).  XFree86 core dumps indicate that it happens in
> random places, in old as dirt software rendering code that has nothing
> wrong with it.  I've only seen this under 2.3.x/2.4 SMP kernels.  I
> would say that this is definitely a kernel problem. 

XFree86 3.9 and XFree86 4 were rock solid for a _long_ time on 2.[34]
kernels - even on my BP6¹. The random crashes started to happen when I
upgraded my distribution² - and are only seen by people using 2.4. So I
suspect that it's the combination of glibc and kernel which is triggering
it.

--
dwmw2

¹ And the BP6 still falls over less frequently than the dual P3 I use at 
work.
² RH7. Don't start.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
