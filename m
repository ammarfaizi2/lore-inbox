Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262634AbRGKSI5>; Wed, 11 Jul 2001 14:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263089AbRGKSIs>; Wed, 11 Jul 2001 14:08:48 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:37288 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262634AbRGKSIf>; Wed, 11 Jul 2001 14:08:35 -0400
Message-ID: <3B4C960E.56C58319@kernelconcepts.de>
Date: Wed, 11 Jul 2001 20:08:14 +0200
From: Nils Faerber <nils@kernelconcepts.de>
Organization: kernel concepts
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: forcing irq for a particular pci device
In-Reply-To: <Pine.LNX.4.33.0107111314040.13823-100000@terbidium.openservices.net>
Content-Type: multipart/mixed;
 boundary="------------D717CA2A645A465A77022983"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D717CA2A645A465A77022983
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ignacio Vazquez-Abrams wrote:
> On Wed, 11 Jul 2001, MEHTA,HIREN (A-SanJose,ex1) wrote:
> > Hi List,
> > Is there any way to force a particular irq for a particular
> > pci device ?
> > -hiren
> Try the "PCI Options" section of your computer's BIOS.

But this is not an option for many machines like my notebook for
example. There I have the problem that the PCI IRQs seem to be allocated
by random. Sometimes the USB controller shares the interrupt with the
soundcard which saves one IRQ for PCMCIA devices and sometimes seperate
IRQs are used.
It would be really nice if one could change that and accumulate devices
that _can_ share interrupts on one single IRQ.

> Ignacio Vazquez-Abrams  <ignacio@openservices.net>
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--
--------------D717CA2A645A465A77022983
Content-Type: text/x-vcard; charset=us-ascii;
 name="nils.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nils Faerber
Content-Disposition: attachment;
 filename="nils.vcf"

begin:vcard 
n:Faerber;Nils
tel;cell:+49-170-2729106
tel;fax:+49-271-771091-19
tel;work:+49-271-771091-12
x-mozilla-html:FALSE
url:http://www.kernelconcepts.de
org:kernel concepts
adr:;;Dreisbachstrasse 24;Netphen;;57250;Germany
version:2.1
email;internet:nils@kernelconcepts.de
x-mozilla-cpt:;0
fn:Nils Faerber
end:vcard

--------------D717CA2A645A465A77022983--

