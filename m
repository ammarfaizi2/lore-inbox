Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSHGWDA>; Wed, 7 Aug 2002 18:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSHGWDA>; Wed, 7 Aug 2002 18:03:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21253 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313181AbSHGWC7>; Wed, 7 Aug 2002 18:02:59 -0400
Date: Wed, 7 Aug 2002 23:06:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, mporter@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.30/arch/arm/mach-iop310/iq80310-pci.c BUG_ON(cond1 || cond2) separation
Message-ID: <20020807230635.A13078@flint.arm.linux.org.uk>
References: <20020805131740.A2433@baldur.yggdrasil.com> <20011101234824.A69@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20011101234824.A69@toy.ucw.cz>; from pavel@suse.cz on Thu, Nov 01, 2001 at 11:48:25PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 11:48:25PM +0000, Pavel Machek wrote:
> it makes code slower/bigger... probably bad idea

Its actually not in a performance critical area, so the "slower" argument
doesn't apply.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

