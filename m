Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265893AbUKAPpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265893AbUKAPpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272779AbUKAPhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 10:37:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43527 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266753AbUKAOfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:35:16 -0500
Date: Mon, 1 Nov 2004 14:35:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tim_T_Murphy@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Message-ID: <20041101143510.A5079@flint.arm.linux.org.uk>
Mail-Followup-To: Tim_T_Murphy@Dell.com, linux-kernel@vger.kernel.org
References: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC7@ausx2kmps304.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC7@ausx2kmps304.aus.amer.dell.com>; from Tim_T_Murphy@Dell.com on Mon, Nov 01, 2004 at 08:28:35AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 08:28:35AM -0600, Tim_T_Murphy@Dell.com wrote:
> > Ok, could you check whether this patch automatically detects 
> > the serial port please?
> 
> Yes, other than fixing a couple typos: 
> 	uart_offest -> uart_offset
> 	PCI_ID_ANY -> PCI_ANY_ID

Thanks for testing - I'll be adding this to mainline kernels.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
