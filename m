Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266080AbUANJSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265439AbUANJRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:17:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30219 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265848AbUANJQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:16:37 -0500
Date: Wed, 14 Jan 2004 09:16:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Add CONFIG for -mregparm=3
Message-ID: <20040114091630.A14739@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@muc.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, jh@suse.cz
References: <20040114090603.GA1935@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040114090603.GA1935@averell>; from ak@muc.de on Wed, Jan 14, 2004 at 10:06:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 10:06:03AM +0100, Andi Kleen wrote:
> Using -mregparm=3 shrinks the kernel further:

Note that there is a dependence on this patch - as highlighted by Arjan,
CardServices() breaks when built on x86 with -mregparm.

Therefore, the CardServices() patches need to be merged into any tree
prior to this patch.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
