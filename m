Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbSL3QMB>; Mon, 30 Dec 2002 11:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbSL3QMB>; Mon, 30 Dec 2002 11:12:01 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28545
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266995AbSL3QMA>; Mon, 30 Dec 2002 11:12:00 -0500
Subject: Re: APIC with SIS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021230170822.1b79ebb3.skraw@ithnet.com>
References: <20021230170822.1b79ebb3.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 17:02:03 +0000
Message-Id: <1041267723.13956.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 16:08, Stephan von Krawczynski wrote:
> Hello,
> 
> can any kind soul tell me the chances for implementation of:
> 
> <6>PCI: Using IRQ router SIS [1039/0008] at 00:01.0
> <6>SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented
> 
> in 2.4 ?
> This message shows up if enabling APIC on boards with SIS630 chipset.

You need some kernel patches, updated ACPI and ACPI enabled to use the
SIS APIC in this setup

