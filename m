Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265322AbSJXFwb>; Thu, 24 Oct 2002 01:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSJXFwb>; Thu, 24 Oct 2002 01:52:31 -0400
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.156]:12502 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S265322AbSJXFwb>; Thu, 24 Oct 2002 01:52:31 -0400
X-Biglobe-Sender: <t-kouchi@mvf.biglobe.ne.jp>
Date: Wed, 23 Oct 2002 22:59:34 -0700
From: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
To: greg@kroah.com, jung-ik.lee@intel.com
Subject: Re: PCI Hotplug Drivers for 2.5
Cc: tony.luck@intel.com, pcihpd-discuss@lists.sourceforge.net,
       linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
In-Reply-To: <20021024051008.GA19557@kroah.com>
References: <72B3FD82E303D611BD0100508BB29735046DFF3F@orsmsx102.jf.intel.com> <20021024051008.GA19557@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.04
Message-Id: <20021024145839.OAHRC0A82654.59A07363@mvf.biglobe.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 23 Oct 2002 22:10:08 -0700
Greg KH <greg@kroah.com> wrote:

> Also, why doesn't the ACPI PCI hotplug driver work for your machines?
> I've seen it work on a very wide range of processors (i386 and ia64),
> and manufacturers, and any specific issues with your hardware would
> probably be better addressed with patches to the existing ACPI driver.

The ACPI spec provides very limited control of actual hardware
(With ACPI, we don't have common method for controlling such as Bus
speed, LED etc.).
So if a hardware comes with well-documented hotplug controller, we
can achieve finer control over the hardware.

The SHPC specification defines it still depends on ACPI for managing
resources, etc.  So resource management portion can be and *should be*
shared with all PCI hotplug drivers that use ACPI for resource
management.

I think the most important thing is everyone agree on the direction
in which we should go before we code anything, in order not to waste
our time.

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi@cq.jp.nec.com/t-kouchi@mvf.biglobe.ne.jp>

