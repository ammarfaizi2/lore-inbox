Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWGFPRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWGFPRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWGFPRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:17:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30220 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030316AbWGFPRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:17:14 -0400
Date: Thu, 6 Jul 2006 16:17:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060706151705.GB1399@flint.arm.linux.org.uk>
Mail-Followup-To: Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com> <20060706021906.1af7ffa3.akpm@osdl.org> <1152179893.3084.26.camel@laptopd505.fenrus.org> <20060706124315.2188c700@cad-250-152.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706124315.2188c700@cad-250-152.norway.atmel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 12:43:15PM +0200, Haavard Skinnemoen wrote:
> On Thu, 06 Jul 2006 11:58:13 +0200
> Arjan van de Ven <arjan@infradead.org> wrote:
> > > 	+EXPORT_SYMBOL(clk_get);
> > > 	+EXPORT_SYMBOL(clk_put);
> > > 	+EXPORT_SYMBOL(clk_enable);
> > > 	+EXPORT_SYMBOL(clk_disable);
> > > 	+EXPORT_SYMBOL(clk_get_rate);
> > > 	+EXPORT_SYMBOL(clk_round_rate);
> > > 	+EXPORT_SYMBOL(clk_set_rate);
> > > 	+EXPORT_SYMBOL(clk_set_parent);
> > > 	+EXPORT_SYMBOL(clk_get_parent);
> > 
> > probably wants to be _GPL exports anyway
> 
> If so, ARM should probably be converted as well. On SH, they are
> actually _GPL exports.

That depends if you consider them to be a low level API or not.  I don't.
They're staying as non-GPL on ARM, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
