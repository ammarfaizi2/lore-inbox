Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266804AbTAIQBR>; Thu, 9 Jan 2003 11:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbTAIQBR>; Thu, 9 Jan 2003 11:01:17 -0500
Received: from mail.ithnet.com ([217.64.64.8]:32274 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S266804AbTAIQBQ>;
	Thu, 9 Jan 2003 11:01:16 -0500
Date: Thu, 9 Jan 2003 17:09:48 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC with SIS
Message-Id: <20030109170948.7f8d4a42.skraw@ithnet.com>
In-Reply-To: <1041268709.13684.28.camel@irongate.swansea.linux.org.uk>
References: <20021230170822.1b79ebb3.skraw@ithnet.com>
	<1041267723.13956.24.camel@irongate.swansea.linux.org.uk>
	<20021230173333.5f28edb9.skraw@ithnet.com>
	<1041268709.13684.28.camel@irongate.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Dec 2002 17:18:29 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mon, 2002-12-30 at 16:33, Stephan von Krawczynski wrote:
> > > You need some kernel patches, updated ACPI and ACPI enabled to use the
> > > SIS APIC in this setup
> > 
> > Where to find?
> 
> Current ACPI is on sourceforge. The SIS APIC workaround bits haven't yet
> been backported to 2.4, so you either do the backport or wait 8)

Ok, so I took ACPI from sf and voila: it works now! I took the patch for 2.4.20
and it does fine. Are there chances to include this in the mainstream? Without
my SIS-based motherboards do not work at all with shared interrupts (which you
actually cannot prevent due to lacking bios support for pci-irq mapping).

BTW: I tried 2.4.21-pre[1-3] and none did work, of course.
-- 
Regards,
Stephan

