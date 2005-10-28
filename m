Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965203AbVJ1JYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbVJ1JYP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 05:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbVJ1JYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 05:24:15 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:45226 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S965203AbVJ1JYP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 05:24:15 -0400
Date: Fri, 28 Oct 2005 11:24:13 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: John Bowler <jbowler@acm.org>
Cc: "'Deepak Saxena'" <dsaxena@plexity.net>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [PATCH] 2.6.14: NSLU2 machine support
Message-ID: <20051028092412.GA27155@xi.wantstofly.org>
References: <001501c5db94$40eca320$1001a8c0@kalmiopsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001501c5db94$40eca320$1001a8c0@kalmiopsis>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 12:50:22AM -0700, John Bowler wrote:

> +static irqreturn_t nslu2_reset_handler(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	/* FIXME This doesn't reset the NSLU2. It powers it off.
> +	 * Close enough, since reset is unreliable
> +	 */

Is this comment still valid?

Looks good otherwise!


--L
