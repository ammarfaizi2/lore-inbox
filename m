Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVA0OpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVA0OpD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 09:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVA0OpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 09:45:03 -0500
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:24960
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S262634AbVA0Oo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 09:44:59 -0500
Date: Thu, 27 Jan 2005 14:44:41 +0000
From: Ben Dooks <ben@fluff.org>
To: Ara Avanesyan <araav@hylink.am>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ixdp4xx restart. watchdog enable value
Message-ID: <20050127144441.GB4848@home.fluff.org>
References: <006b01c5047e$1efc78a0$1000000a@araavanesyan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006b01c5047e$1efc78a0$1000000a@araavanesyan>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 06:40:17PM +0400, Ara Avanesyan wrote:
> in file: include/asm-arm/arch-ixp4x//system.h
> function: arch_reset
> 
> code snap --
> /* disable watchdog interrupt, enable reset, enable count */
> *IXP4XX_OSWE = 0x3;
> --
> 
> according to intel's documentation the appropriate bits are in the
> following order:
> bit 2: wdog_cnt_ena
> bit 1: wdog_int_ena
> bit 0: wdog_rst_ena
> 
> so the above assigned value should be 101b == 0x5.
> I do not know why 0x3 works at all. Btw, u-boot assigns 0x5.
> 
> This is for all kernels I had a chance to look at (2.4.20-2.6.10).

Best place to air this is linux-arm-kernel@lists.arm.linux.org.uk
where all ARM kernel related discussions go on.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
