Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVF1JAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVF1JAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVF1I6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:58:39 -0400
Received: from verein.lst.de ([213.95.11.210]:39827 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261424AbVF1I5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:57:17 -0400
Date: Tue, 28 Jun 2005 10:57:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32: Remove CONFIG_PMAC_PBOOK
Message-ID: <20050628085701.GA31218@lst.de>
References: <1119847159.5133.106.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119847159.5133.106.camel@gaston>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 02:39:16PM +1000, Benjamin Herrenschmidt wrote:
> This patch removes CONFIG_PMAC_PBOOK (PowerBook support). This is now
> split into CONFIG_PMAC_MEDIABAY for the actual hotswap bay that some
> powerbooks have, CONFIG_PM for power management related code, and just
> left out of any CONFIG_* option for some generally useful stuff that can
> be used on non-laptops as well.

Can you clarify the CONFIG_PMAC_MEDIABAY for which powerbooks this
is needed exactly?  AFAIK up to one of the G3 models, but you probably
know better :)

