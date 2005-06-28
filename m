Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVF1X6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVF1X6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVF1X6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:58:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:63902 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262253AbVF1X5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:57:54 -0400
Subject: Re: [PATCH] ppc32: Remove CONFIG_PMAC_PBOOK
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <931dc22c9709211c29f2d9d504d8ff9e@kernel.crashing.org>
References: <1119847159.5133.106.camel@gaston>
	 <931dc22c9709211c29f2d9d504d8ff9e@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 09:52:24 +1000
Message-Id: <1120002744.5133.212.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 09:43 +0200, Segher Boessenkool wrote:
> > This patch removes CONFIG_PMAC_PBOOK (PowerBook support). This is now
> > split into CONFIG_PMAC_MEDIABAY for the actual hotswap bay that some
> > powerbooks have, CONFIG_PM for power management related code, and just
> > left out of any CONFIG_* option for some generally useful stuff that 
> > can
> > be used on non-laptops as well.
> 
> Is there any real reason not to enable CONFIG_PM on all Macs

People using old desktop machines with little memory may want to keep
the RAM footprint low :)

Ben.


