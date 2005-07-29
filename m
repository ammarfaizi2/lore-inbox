Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVG2Fsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVG2Fsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 01:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVG2Fsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 01:48:30 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:54152 "EHLO smtp2.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262377AbVG2Fs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 01:48:29 -0400
X-ME-UUID: 20050729054827767.BB5051C00217@mwinf0212.wanadoo.fr
Subject: Re: Time Flies (Twice as Fast)
From: Olivier Fourdan <fourdan@xfce.org>
To: Kurt Wall <kwall@kurtwerks.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050729020332.GA12920@kurtwerks.com>
References: <20050729020332.GA12920@kurtwerks.com>
Content-Type: text/plain
Organization: http://www.xfce.org
Date: Fri, 29 Jul 2005 07:48:32 +0200
Message-Id: <1122616112.5929.2.camel@shuttle>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kurt

Did you try with the "no_timer_check" boot option?

HTH
Olivier.

On Thu, 2005-07-28 at 22:03 -0400, Kurt Wall wrote:
> Hola,
> 
> I have an eMachines T6212 Opteron system on which the system clock
> seems to run at ~twice the speed of the wall clock. The main board
> is an ASUS K8 of some description with at ATI SB400 southbridge and
> an ATI RS480 northbridge. Kernel version is 2.6.12.3.
> 
> If I disable ACPI, the clock slows down to what seems to be the proper
> speed, but then my NIC doesn't work, presumably because it shares
> an interrupt with something else.
> 
> I've tried booting with clock=tsc and clock=pit to no effect. Based
> on my review of the list archives, there appears to be issues with
> the chipset, but I haven't been able to sort out what the real problem
> is and the appropriate solution.
> 
> There's an ACPI error that seems potentially troublesome:
> 
> ACPI: Subsystem revision 20050309
>     ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LPC0.LNK0] in namespace, AE_NOT_FOUND
> search_node ffff81001fec9440 start_node ffff81001fec9440 return_node 0000000000000000
> 
> I also see this message from the PCI subsystem:
> 
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
> 
> As a starting point, I've attached lspci output and the boot log. I'm
> willing to provide more information and try patches and such.
> 
> Thanks.
> 
> Kurt
> 


