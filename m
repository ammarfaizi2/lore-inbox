Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270212AbTGRLXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 07:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271682AbTGRLXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 07:23:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56530
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270212AbTGRLXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 07:23:39 -0400
Subject: Re: [PATCH] PATCH: typo bits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0307181221390.22944-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0307181221390.22944-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058528165.19558.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jul 2003 12:36:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -  dep_tristate '  SL811HS Alternate (support isochornous mode)' CONFIG_USB_SL811HS_ALT $CONFIG_USB
> > +   dep_tristate '  SL811HS Alternate (support isosynchronous mode)' CONFIG_USB_SL811HS_ALT $CONFIG_USB
> >  fi
> > diff -Nru a/drivers/usb/host/sl811.c b/drivers/usb/host/sl811.c
> > --- a/drivers/usb/host/sl811.c	Thu Jul 17 11:07:46 2003
> > +++ b/drivers/usb/host/sl811.c	Thu Jul 17 11:07:46 2003
> > @@ -9,7 +9,7 @@
> >   * 	  Adam Richter, Gregory P. Smith;
> >    	2.Original SL811 driver (hc_sl811.o) by Pei Liu <pbl@cypress.com>
> >   *
> > - * It's now support isochronous mode and more effective than hc_sl811.o
> > + * It's now support isosynchronous mode and more effective than hc_sl811.o
> 
> I thought the correct term was `isochronous'...

Perhaps someone can clarify - however isochornus is definitely wrong either way

