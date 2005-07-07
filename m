Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVGGP2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVGGP2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVGGPZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 11:25:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6337 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261484AbVGGPZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 11:25:18 -0400
Subject: Re: [RFC] Atmel-supplied hardware headers for AT91RM9200 SoC
	processor
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Victor <andrew@sanpeople.com>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <1120749256.16806.146.camel@fuzzie.sanpeople.com>
References: <1120730318.16806.75.camel@fuzzie.sanpeople.com>
	 <1120747271.19467.388.camel@hades.cambridge.redhat.com>
	 <1120749256.16806.146.camel@fuzzie.sanpeople.com>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 16:26:12 +0100
Message-Id: <1120749972.19467.396.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-07 at 17:14 +0200, Andrew Victor wrote:
> 
> The hardware headers can't be GPL since they're also used on other
> non-Linux systems.  The best we can probably get is a BSD-style
> license.
> 
> Regarding the actual wording, try:
>   grep -r "Redistributions in binary form" * | grep -v minimum
> 
> I count 130 instances of the same requirement in 2.6.13-rc2, though
> some of the files are dual-licensed.

They should _all_ be dual-licensed if they carry the advertising clause,
unless they're actually derived from true UCB code (in which case the
advertising clause is revoked).

Yours certainly should be under dual licence.

-- 
dwmw2

