Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbUAHJgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 04:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbUAHJgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 04:36:49 -0500
Received: from [193.138.115.2] ([193.138.115.2]:24845 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263903AbUAHJgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 04:36:48 -0500
Date: Thu, 8 Jan 2004 10:33:24 +0100 (CET)
From: Jesper Juhl <juhl@dif.dk>
To: Joe Perches <joe@perches.com>
cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       Mark Hemment <markhe@nextd.demon.co.uk>,
       Andrea Arcangeli <andrea@e-mind.com>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] mm/slab.c remove impossible <0 check - size_t is not
 signed - patch is against 2.6.1-rc1-mm2
In-Reply-To: <1073531294.2304.18.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.56.0401081032590.10083@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401080204060.9700@jju_lnx.backbone.dif.dk>
 <1073531294.2304.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Jan 2004, Joe Perches wrote:

> On Wed, 2004-01-07 at 17:20, Jesper Juhl wrote:
> > size_t is an unsigned datatype in all archs.
>
> There are literally hundreds of these in the code.
>
> Compile with -W -Wall and see for yourself.
>

Well, anything wrong in cleaning them up?


-- Jesper Juhl

