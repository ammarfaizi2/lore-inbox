Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262408AbTDALmJ>; Tue, 1 Apr 2003 06:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262423AbTDALmJ>; Tue, 1 Apr 2003 06:42:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52484 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262408AbTDALmI>; Tue, 1 Apr 2003 06:42:08 -0500
Date: Tue, 1 Apr 2003 12:53:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.66-mm2-1 freezes solid after init PCMCIA
Message-ID: <20030401125328.B30470@flint.arm.linux.org.uk>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <1049196020.789.8.camel@teapot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1049196020.789.8.camel@teapot>; from felipe_alfaro@linuxmail.org on Tue, Apr 01, 2003 at 01:20:21PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 01:20:21PM +0200, Felipe Alfaro Solana wrote:
> PCI: Found IRQ 10 for device 00:0c.0
> yenta 00:0c.0: Preassigned resource 3 busy, reconfiguring...
> Yenta IRQ list 08d8, PCI irq10
> Socket status: 30000006
> PCI: Found IRQ 5 for device 00:0c.1
> PCI: Sharing IRQ 5 with 00:09.0
> yenta 00:0c.1: Preassigned resource 2 busy, reconfiguring...
> yenta 00:0c.1: Preassigned resource 3 busy, reconfiguring...
> Yenta IRQ list 08d8, PCI irq5
> Socket status: 30000020
> 
> At this point, the machine hangs. This didn't happen with 2.5.66-mm1 or
> 2.5.66-mm2 (but it happens with 2.5.66-mm2-1). I'm 99% sure this is
> caused by Dominik or Russell King PCMCIA patches.

What happens if you boot without the cardbus card inserted?  If this
works, please send lspci -vv output.  What happens if you insert the
cardbus card?  If this works, again, please send the lspci -vv output.

Please send lspci -vv output under a kernel which works with the card
inserted.

(so you should have up to 3 lspci outputs to send me.)

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

