Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVADNFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVADNFY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVADNFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:05:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53003 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261599AbVADNFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:05:19 -0500
Date: Tue, 4 Jan 2005 13:05:15 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: dm: introduce pm_message_t
Message-ID: <20050104130515.B18550@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>,
	Andrew Morton <akpm@zip.com.au>
References: <20050104123938.GA13716@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050104123938.GA13716@elf.ucw.cz>; from pavel@ucw.cz on Tue, Jan 04, 2005 at 01:39:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 01:39:38PM +0100, Pavel Machek wrote:
> +FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
> +scratch. That probably means stop accepting upstream requests, the
> +actual policy of what to do with them beeing specific to a given

busy busy bee.  I think you mean "being".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
