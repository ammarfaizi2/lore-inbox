Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbQLHOhW>; Fri, 8 Dec 2000 09:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbQLHOhL>; Fri, 8 Dec 2000 09:37:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28176 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129667AbQLHOgw>; Fri, 8 Dec 2000 09:36:52 -0500
Subject: Re: Signal 11
To: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 8 Dec 2000 14:06:45 +0000 (GMT)
Cc: ak@suse.de (Andi Kleen), rmager@vgkk.com (Rainer Mager),
        linux-kernel@vger.kernel.org, mvojkovich@valinux.com (Mark Vojkovich)
In-Reply-To: <25692.976268767@redhat.com> from "David Woodhouse" at Dec 08, 2000 09:46:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144OAg-0003wh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > wrong with it.  I've only seen this under 2.3.x/2.4 SMP kernels.  I
> > would say that this is definitely a kernel problem.=20
> 
> XFree86 3.9 and XFree86 4 were rock solid for a _long_ time on 2.[34]
> kernels - even on my BP6=B9. The random crashes started to happen when =
> I
> upgraded my distribution=B2 - and are only seen by people using 2.4. So=
>  I
> suspect that it's the combination of glibc and kernel which is triggeri=
> ng
> it.

Have any of the folks seeing it checked if Ben LaHaise's fixes for the page
table updating race help ?

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
