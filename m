Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276641AbRJYXGI>; Thu, 25 Oct 2001 19:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276642AbRJYXF7>; Thu, 25 Oct 2001 19:05:59 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:12543 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S276641AbRJYXFp>; Thu, 25 Oct 2001 19:05:45 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C42D6B7@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Xavier Bestel'" <xavier.bestel@free.fr>
Cc: "'Gert-Jan Rodenburg'" <hertog@home.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Issue wit ACPI and Promise?
Date: Thu, 25 Oct 2001 16:06:14 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Xavier Bestel [mailto:xavier.bestel@free.fr]
> > Either the ACPI interrupt handler is not sharing properly 
> or the promise
> > interrupt handler isn't. Given that I can't duplicate it, 
> I'm reduced to
> > waiting for some kind soul to send a patch.. :-(
> 
> I've seen exactely this problem (reproducable, and I'm not alone),
> without Promise. It seems it's ACPI.

Great. Since I don't have the HW I need your help.

Please stick printk()s in drivers/acpi/events/evsci.c acpi_ev_sci_handler().

I'd like to know where in there it is hanging, and if it is ever returning.
I don't know your level of comfortability in all this so please email me if
you need more explicit instructions on what I'm asking for.

Thanks in advance! ;-)

Regards -- Andy
