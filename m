Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbVJCPPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVJCPPB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVJCPPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:15:01 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:60819 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751057AbVJCPPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:15:00 -0400
X-ORBL: [69.107.75.50]
Date: Mon, 03 Oct 2005 08:14:57 -0700
From: David Brownell <david-b@pacbell.net>
To: basicmark@yahoo.com, arjan@infradead.org
Subject: Re: [RFC][PATCH] SPI subsystem
Cc: linux-kernel@vger.kernel.org
References: <20051003105748.213.qmail@web33014.mail.mud.yahoo.com>
 <1128337656.17024.10.camel@laptopd505.fenrus.org>
In-Reply-To: <1128337656.17024.10.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051003151457.AD64FEE8CE@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Arjan van de Ven <arjan@infradead.org>
> Date: Mon, 03 Oct 2005 13:07:36 +0200
>
> please NEVER EVER do dma from or to a stack variable. It's not allowed
> on all architectures and it is really really bad practice in general
> anyway. 

Arjan, could you mention some Linuxes which don't allow it?

Every time the topic of DMA to/from stack comes up, the advice is
always to avoid it ... but so far as I recall, nobody's yet provided
us with an example where it actually doesn't work.

Failing such examples, it's normal to discount such dire warnings and
just plan to apply the relevant minor tweaks if/when they're needed.

- Dave


