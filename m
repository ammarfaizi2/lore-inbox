Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933690AbWKQQJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933690AbWKQQJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933692AbWKQQJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:09:59 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:64272 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S933690AbWKQQJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:09:58 -0500
Date: Fri, 17 Nov 2006 16:09:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
Subject: Re: [patch 1/6] [RFC] Add MMC Password Protection (lock/unlock) support V6
Message-ID: <20061117160951.GD28514@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <anderson.briglia@indt.org.br>,
	"Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>,
	linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
	ext David Brownell <david-b@pacbell.net>,
	Tony Lindgren <tony@atomide.com>,
	"Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
	"Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
References: <455DB297.1040009@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455DB297.1040009@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 09:01:11AM -0400, Anderson Briglia wrote:
>  #define MMC_CAP_BYTEBLOCK	(1 << 2)	/* Can do non-log2 block 
>  sizes */
> +#define MMC_CAP_LOCK_UNLOCK	(1 << 3)	/* Host password support 
> capability */

What's the point of this capability.  If the host can do BYTEBLOCK transfers
it can send the password commands.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
