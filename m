Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbTAIRt4>; Thu, 9 Jan 2003 12:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbTAIRt4>; Thu, 9 Jan 2003 12:49:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6030
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266933AbTAIRtz>; Thu, 9 Jan 2003 12:49:55 -0500
Subject: Re: APIC with SIS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Justin Cormack <justin@street-vision.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030109184222.71dff627.skraw@ithnet.com>
References: <20021230170822.1b79ebb3.skraw@ithnet.com>
	 <1041267723.13956.24.camel@irongate.swansea.linux.org.uk>
	 <20021230173333.5f28edb9.skraw@ithnet.com>
	 <1041268709.13684.28.camel@irongate.swansea.linux.org.uk>
	 <20030109170948.7f8d4a42.skraw@ithnet.com> <1042130749.25527.5.camel@lotte>
	 <20030109175915.1c9dd425.skraw@ithnet.com> <1042131701.25527.8.camel@lotte>
	 <20030109184222.71dff627.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042137863.27796.46.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Jan 2003 18:44:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 17:42, Stephan von Krawczynski wrote:
> > It looks like I managed to set something to turn shared interrupts off
> > too (because initially I was getting the shared int hang). Cant look in
> > the BIOS right now...
> 
> You don't have to, just look at cat /proc/interrupts to see if some are shared ...

SiS APIC is not supported in 2.4. That it happens to work on your board with
ACPI is I suspect mostly luck

