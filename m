Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbUBFIjL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 03:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbUBFIjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 03:39:11 -0500
Received: from tristate.vision.ee ([194.204.30.144]:57475 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S264473AbUBFIjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 03:39:07 -0500
Message-ID: <402352A9.7090705@vision.ee>
Date: Fri, 06 Feb 2004 10:39:05 +0200
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: s0348365@sms.ed.ac.uk
Cc: Arjen Verweij <A.Verweij2@ewi.tudelft.nl>, Andrew Morton <akpm@osdl.org>,
       =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
References: <20040205014405.5a2cf529.akpm@osdl.org> <200402051357.04005.s0348365@sms.ed.ac.uk> <4022505B.1020900@vision.ee> <200402052130.30344.s0348365@sms.ed.ac.uk>
In-Reply-To: <200402052130.30344.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:

>This fix doesn't work for me because I get problems if I disable ACPI IRQ 
>routing and still have apic enabled. Normally these problems would be 
>gracefully solved, but my USB HCD complains about not having been assigned an 
>IRQ.
>  
>
Actually it's exactly the same here I'm just not bothered by my USB HCD 
not having an IRQ since
my USB mouse still works.

It says this when booting:

PCI: No IRQ known for interrupt pin A of device 0000:00:02.0. Please try 
using pci=biosirq.
drivers/usb/core/hcd-pci.c: Found HC with no IRQ.  Check BIOS/PCI 
0000:00:02.0 setup!

All I can say is that in 2.6.1-rc1-mm1 it worked and I could have all my 
interrupts off the XT-PIC.

Lenar
