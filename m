Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbTICOXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbTICOXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:23:03 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:64459 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262260AbTICOXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:23:01 -0400
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx
	doesn't work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Damian Kolkowski <deimos@deimos.one.pl>,
       Danny ter Haar <dth@ncc1701.cistron.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16213.46254.376174.466098@gargle.gargle.HOWL>
References: <bj447c$el6$1@news.cistron.nl>
	 <20030903074902.GA1786@deimos.one.pl>
	 <16213.46254.376174.466098@gargle.gargle.HOWL>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062598918.19059.54.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 15:21:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 10:30, Mikael Pettersson wrote:
> It's impossible to have an APIC bug on a C3 board, because the processor
> simply doesn't have one!

The chipset does and not writing PCI_INTERRUPT_LINE and other things
properly can cause problems if its directing interrupts to the chipset
I/O APIC wrongly not the PIC and thus the CPU

