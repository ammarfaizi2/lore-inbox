Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTKNHxC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 02:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTKNHxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 02:53:02 -0500
Received: from mx.stud.uni-hannover.de ([130.75.176.3]:19677 "EHLO
	studserv.stud.uni-hannover.de") by vger.kernel.org with ESMTP
	id S261460AbTKNHw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 02:52:59 -0500
From: Michael Born <michael.born@stud.uni-hannover.de>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI: device 00:09.0 has unknown header type 04, ignoring.  What's that?
Date: Fri, 14 Nov 2003 08:52:57 +0100
User-Agent: KMail/1.5.3
References: <Pine.GSO.4.33.0311131543430.26356-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0311131543430.26356-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311140852.58026.michael.born@stud.uni-hannover.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for your responses. I did some more testing and have one more 
question.
In the "nonshared IRQ" PCI slot 0.9.0 the card works with the Quancom driver 
under Win2k but is ignored by linux 2.4.22 - as I wrote before.
In "shared IRQ" PCI slot 0.c.0 the card is recognized by linux - lspci:
00:0c.0 Class ff00: Quancom Electronic GmbH: Unknown device 3302 (rev 11)

The driver I use is open source ( see: http://linux-gpib.sourceforge.net/ ). 
The maintainer helped me a lot to get this Ines-GPIB clone card running.

Is there a board / vendor who has good BIOS and PCI implementations? 
If I understand correctly - there is no simple way to tell a good PCI card 
apart from a bad one ? If I would send back the card they would want to know 
what exactly the problem ist - but when nobody knows that ???

Greetings
Michael


Am Donnerstag, 13. November 2003 21:57 schrieb Ricky Beam:
> On Thu, 13 Nov 2003, Richard B. Johnson wrote:
> >> While booting the kernel says:
> >> ---
> >> <6>PCI: Probing PCI hardware
> >> <4>PCI: ACPI tables contain no PCI IRQ routing entries
> >> <4>PCI: Probing PCI hardware (bus 00)
> >> <3>PCI: device 00:09.0 has unknown header type 04, ignoring.
> >> <6>PCI: Using IRQ router VIA [1106/3074] at 00:11.0
> >
> >We don't know if 00:09.0 is your board, but a header type 04
> >is currently not defined. There are three header types, 0->2.

