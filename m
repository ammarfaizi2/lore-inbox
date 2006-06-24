Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWFXRlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWFXRlL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 13:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWFXRlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 13:41:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5342 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750983AbWFXRlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 13:41:09 -0400
Subject: Re: 2.6.17-...: looong writeouts
From: Arjan van de Ven <arjan@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Donald Parsons <dparsons@brightdsl.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060624173658.GB7565@martell.zuzino.mipt.ru>
References: <1151166629.4409.18.camel@danny.parsons.org>
	 <1151167852.3181.65.camel@laptopd505.fenrus.org>
	 <20060624173658.GB7565@martell.zuzino.mipt.ru>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 19:41:05 +0200
Message-Id: <1151170866.3181.71.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 21:36 +0400, Alexey Dobriyan wrote:
> On Sat, Jun 24, 2006 at 06:50:52PM +0200, Arjan van de Ven wrote:
> > just a random question to rule things out: can you check if laptop mode
> > is enabled? (see the /proc/sys/vm/laptop_mode file). Laptop mode will
> > have the effect of grouping writes together, so if that got enabled
> > accidentally for some reason, that could explain the behavior you are
> > seeing. (and it would narrow down the "what broke" search problem to
> > something that is a lot easier to work on)
> 
> Mine is not laptop and I've never enabled it.

but a script in your distro might have...


