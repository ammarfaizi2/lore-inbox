Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbTIDKHI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 06:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbTIDKHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 06:07:07 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:35793 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264851AbTIDKHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 06:07:05 -0400
Subject: Re: What is the SiI 0680 chipset status?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomasz =?ISO-8859-1?Q?B=B1tor?= <tomba@bartek.tu.kielce.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030904014207.GA8579@bartek.tu.kielce.pl>
References: <20030902165537.GA1830@bartek.tu.kielce.pl>
	 <1062589779.19059.8.camel@dhcp23.swansea.linux.org.uk>
	 <20030904014207.GA8579@bartek.tu.kielce.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1062669964.21777.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Thu, 04 Sep 2003 11:06:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-04 at 02:42, Tomasz B±tor wrote:
> It doesn't for me. I have no idea what could I possibly do wrong, but
> I've tried dozens of possibilities without any luck. Compiling in
> siimage.c = drive errors, ide2 reset and infinite loop of "lost
> interrupt" messages at boot time. Without siimage.c compiled and with
> ide2=xxx ide3=xxx parameters in lilo, disks are visible, but of course
> there is no DMA.
> 
> Any ideas?

If you disable both APIC and ACPI support is it any happier ?

