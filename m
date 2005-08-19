Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932675AbVHSN1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbVHSN1w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 09:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVHSN1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 09:27:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35595 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932675AbVHSN1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 09:27:52 -0400
Date: Fri, 19 Aug 2005 14:27:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
Message-ID: <20050819142746.B2880@flint.arm.linux.org.uk>
Mail-Followup-To: Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050819043331.7bc1f9a9.akpm@osdl.org> <4305DDBF.1060309@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4305DDBF.1060309@ens-lyon.org>; from Brice.Goglin@ens-lyon.org on Fri, Aug 19, 2005 at 03:25:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 03:25:19PM +0200, Brice Goglin wrote:
> arch/i386/kernel/traps.c: In function 'die_nmi':
> arch/i386/kernel/traps.c:633: warning: statement with no effect
> 
> Another smp_nmi_call.
> 
> Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Since you're going to be adding #ifdef CONFIG_SMP...#endif around each
of these, why not fix where it's declared/defined to be empty?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
