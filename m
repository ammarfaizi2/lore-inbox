Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTKPALK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 19:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTKPALK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 19:11:10 -0500
Received: from CPE-138-130-214-20.qld.bigpond.net.au ([138.130.214.20]:8109
	"EHLO jeeves.home.house") by vger.kernel.org with ESMTP
	id S262195AbTKPALI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 19:11:08 -0500
From: Ben Hoskings <ben@jeeves.bpa.nu>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0 yenta_socket eats kernel time on Toshiba Laptop
Date: Sun, 16 Nov 2003 10:11:03 +1000
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <43376.138.130.214.20.1068871325.squirrel@jeeves.home.house> <20031115015927.4e31e6ee.akpm@osdl.org>
In-Reply-To: <20031115015927.4e31e6ee.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311161011.03804.ben@jeeves.bpa.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply, Andrew.

> >  Attepting a modprobe on any of the other PCMCIA bus drivers gives a
> >  'device not found' error.
> >
> >  Under 2.4, the PCMCIA bus uses the i82365 module, which works perfectly.
> >  Under 2.6, it appears that the related driver has been moved to the
> >  yenta_socket module (It's a ToPIC100 Controller; see dmesg below).
>
> Have you tried disabling i82365 in kernel config?

All the PCMCIA options are configured as modules, and when I modprobed 
yenta_socket, the only one already loaded was pcmcia_core. Disabling in the 
kernel config won't make a difference here will it?

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

