Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUEAKlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUEAKlF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 06:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUEAKlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 06:41:05 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:41409 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262190AbUEAKlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 06:41:02 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Duncan Sands <baldrick@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: usbcore.ko linkage problem on x86_64
Date: Sat, 1 May 2004 12:46:18 +0200
User-Agent: KMail/1.5
References: <200404301812.10676.rjwysocki@sisk.pl> <200404302238.40347.baldrick@free.fr>
In-Reply-To: <200404302238.40347.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405011246.18929.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 of April 2004 22:38, Duncan Sands wrote:
> > There seems to be a linkage problem with the usbcore.ko module in the
> > 2.6.6-rc2-mm2 and 2.6.6-rc3-mm1 kernels.  Namely, I get this message:
> >
> > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.6-rc3-mm1;
> > fi WARNING: /lib/modules/2.6.6-rc3-mm1/kernel/drivers/usb/core/usbcore.ko
> > needs unknown symbol destroy_all_async
> >
> > after "make modules_install".  AFAICS, it does not occur for the
> > 2.6.6-rc2 kernel.
>
> Hi RJW, does this help?  (I also got rid of the unused ld2 while I
> was there).
>

Yes, it does. :-)

Greets,
RJW


