Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTLFOFe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 09:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265169AbTLFOFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 09:05:34 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:31730 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S262878AbTLFOFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 09:05:33 -0500
Date: Sat, 6 Dec 2003 09:07:17 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: William Lee Irwin III <wli@holomorphy.com>, Stian Jordet <liste@jordet.nu>,
       Nick Piggin <piggin@cyberone.com.au>, Colin Coe <colin@coesta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
Message-ID: <20031206090717.A3627@mail.kroptech.com>
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com> <20031206024251.GG8039@holomorphy.com> <3FD14396.5070205@cyberone.com.au> <20031206030755.GI8039@holomorphy.com> <1070684918.7934.2.camel@chevrolet.hybel> <20031206043757.GJ8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031206043757.GJ8039@holomorphy.com>; from wli@holomorphy.com on Fri, Dec 05, 2003 at 08:37:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 08:37:57PM -0800, William Lee Irwin III wrote:
> On Sat, Dec 06, 2003 at 05:28:38AM +0100, Stian Jordet wrote:
> > Uhm.. I was under the impression that this was expected behaviour? If
> > not, I guess I'm having problems too?
> >            CPU0       CPU1
> >   0:   91068534         45    IO-APIC-edge  timer
> >   1:      65293          1    IO-APIC-edge  i8042
> >   2:          0          0          XT-PIC  cascade
> >   3:         71          1    IO-APIC-edge  serial
> >   8:     325118          1    IO-APIC-edge  rtc
> >   9:          0          0   IO-APIC-level  acpi
> >  14:     245619          1    IO-APIC-edge  ide0
> 
> Yeah, it looks like it hit you too.
> 
> Could you boot with noirqbalance on the kernel commandline and see if
> the problem goes away?

Sounds like you have things under control, but if you need another data
point I can provide my info. Dual ppro200, same behaviors described in 
this thread. Booting with noirqbalance fixes it.

--Adam

