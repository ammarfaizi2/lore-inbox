Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317668AbSHHRJf>; Thu, 8 Aug 2002 13:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317673AbSHHRJf>; Thu, 8 Aug 2002 13:09:35 -0400
Received: from holomorphy.com ([66.224.33.161]:44441 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317668AbSHHRJe>;
	Thu, 8 Aug 2002 13:09:34 -0400
Date: Thu, 8 Aug 2002 10:13:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: further IO-APIC oddities
Message-ID: <20020808171328.GC15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20020808162856.GD6256@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020808162856.GD6256@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 09:28:56AM -0700, William Lee Irwin III wrote:
> Strange thing happened when I booted the latest x86 discontigmem stuff.
> The stuff where the IO-APIC ID's showed up as zeroed out went away,
> and io_apic.c just bitched about the MPC table entries because it
> doesn't realize that physid's of IO-APIC's mean squat on this box.
> *AND* whatever was scribbling over that table & zeroing it out went
> away. That bug is reproducible on more garden variety machines too.
> If someone who knows how to read the IO-APIC map dumps is around,
> I've included the boot log below.
> Any pointers to where I should print_IO_APIC() early on would also be
> useful.

... from another run, with a printk in apic.c re: mapping the IO-APICs
turned on:

mapped IOAPIC to ffffd000 (fe800000)
mapped IOAPIC to ffffc000 (fe801000)
mapped IOAPIC to ffffb000 (fe840000)
mapped IOAPIC to ffffa000 (fe841000)
mapped IOAPIC to ffff9000 (fe880000)
mapped IOAPIC to ffff8000 (fe881000)
mapped IOAPIC to ffff7000 (fe8c0000)
mapped IOAPIC to ffff6000 (fe8c1000)


Cheers,
Bill
