Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266908AbTAIRdq>; Thu, 9 Jan 2003 12:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266926AbTAIRdq>; Thu, 9 Jan 2003 12:33:46 -0500
Received: from mail.ithnet.com ([217.64.64.8]:38919 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S266908AbTAIRdn>;
	Thu, 9 Jan 2003 12:33:43 -0500
Date: Thu, 9 Jan 2003 18:42:22 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Justin Cormack <justin@street-vision.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: APIC with SIS
Message-Id: <20030109184222.71dff627.skraw@ithnet.com>
In-Reply-To: <1042131701.25527.8.camel@lotte>
References: <20021230170822.1b79ebb3.skraw@ithnet.com>
	<1041267723.13956.24.camel@irongate.swansea.linux.org.uk>
	<20021230173333.5f28edb9.skraw@ithnet.com>
	<1041268709.13684.28.camel@irongate.swansea.linux.org.uk>
	<20030109170948.7f8d4a42.skraw@ithnet.com>
	<1042130749.25527.5.camel@lotte>
	<20030109175915.1c9dd425.skraw@ithnet.com>
	<1042131701.25527.8.camel@lotte>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Jan 2003 17:01:36 +0000
Justin Cormack <justin@street-vision.com> wrote:

> On Thu, 2003-01-09 at 16:59, Stephan von Krawczynski wrote:
> 
> > Unfortunately it is not. Shared interrupts do _not_ work with APIC disabled.
> > They _only_ work with APIC enabled in BIOS _and_ APIC support patch from sf.
> > I tested every other combination and none did work.
> 
> It looks like I managed to set something to turn shared interrupts off
> too (because initially I was getting the shared int hang). Cant look in
> the BIOS right now...

You don't have to, just look at cat /proc/interrupts to see if some are shared ...

-- 
Regards,
Stephan
