Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317701AbSHHRyp>; Thu, 8 Aug 2002 13:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317785AbSHHRyp>; Thu, 8 Aug 2002 13:54:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:64146 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317701AbSHHRyo>; Thu, 8 Aug 2002 13:54:44 -0400
Date: Thu, 08 Aug 2002 10:56:28 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: further IO-APIC oddities
Message-ID: <70720000.1028829388@flay>
In-Reply-To: <20020808162856.GD6256@holomorphy.com>
References: <20020808162856.GD6256@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Strange thing happened when I booted the latest x86 discontigmem stuff.
> The stuff where the IO-APIC ID's showed up as zeroed out went away,
> and io_apic.c just bitched about the MPC table entries because it
> doesn't realize that physid's of IO-APIC's mean squat on this box.
> 
> *AND* whatever was scribbling over that table & zeroing it out went
> away. That bug is reproducible on more garden variety machines too.
> If someone who knows how to read the IO-APIC map dumps is around,
> I've included the boot log below.

I can kind of read them if I really squint, but what are you trying to see / fix?

> ... from another run, with a printk in apic.c re: mapping the IO-APICs
> turned on:
> 
> mapped IOAPIC to ffffd000 (fe800000)
> mapped IOAPIC to ffffc000 (fe801000)
> mapped IOAPIC to ffffb000 (fe840000)
> mapped IOAPIC to ffffa000 (fe841000)
> mapped IOAPIC to ffff9000 (fe880000)
> mapped IOAPIC to ffff8000 (fe881000)
> mapped IOAPIC to ffff7000 (fe8c0000)
> mapped IOAPIC to ffff6000 (fe8c1000)

Looks fine to me ... ?

M.

