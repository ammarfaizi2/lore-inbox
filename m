Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267943AbRGVKCR>; Sun, 22 Jul 2001 06:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267947AbRGVKCH>; Sun, 22 Jul 2001 06:02:07 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:55751 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S267943AbRGVKBs>;
	Sun, 22 Jul 2001 06:01:48 -0400
Date: Sun, 22 Jul 2001 11:28:30 +0200
From: "P.A.M. van Dam" <nucleus@ramoth.xs4all.nl>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7: wtf is "ksoftirqd_CPU0"
Message-ID: <20010722112830.A948@ladystrange.bluehorizon.nl>
In-Reply-To: <3B59AFF7.8061645B@mandrakesoft.com> <200107220023.f6M0Navr022281@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <200107220023.f6M0Navr022281@sleipnir.valparaiso.cl>; from Horst von Brand on Sat, Jul 21, 2001 at 08:23:36PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 21, 2001 at 08:23:36PM -0400, Horst von Brand wrote:
> Jeff Garzik <jgarzik@mandrakesoft.com> said:
> > "peter k." wrote:
> 
> > > i just installed 2.4.7, now a new process called "ksoftirqd_CPU0" is
> > > started automatically when booting (by the kernel obviously)? why? what
> > > does it do?  i didnt find any useful information on it in linuxdoc /
> > > linux-kernel archives
> 
> > it is used internally, ignore it.
> 
> I'd advise not to do so in general: It is a rather tempting name for
> crackers to hide illegal activities.

Kernel daemons/threads still use "reserved pids" (< 100 I believe) so it's
pretty to distinguish them. Ofcourse on 128-way SMP machine, things would
be rather difficult. 

Best regards,

	Pascal


> -- 
> Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
> Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
