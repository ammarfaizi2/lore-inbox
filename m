Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUAHDJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 22:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUAHDJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 22:09:34 -0500
Received: from DSL022.labridge.com ([206.117.136.22]:52497 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S263607AbUAHDJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 22:09:34 -0500
Subject: Re: [PATCH] mm/slab.c remove impossible <0 check - size_t is not
	signed - patch is against 2.6.1-rc1-mm2
From: Joe Perches <joe@perches.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, Mark Hemment <markhe@nextd.demon.co.uk>,
       Andrea Arcangeli <andrea@e-mind.com>,
       Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <Pine.LNX.4.56.0401080204060.9700@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401080204060.9700@jju_lnx.backbone.dif.dk>
Content-Type: text/plain
Message-Id: <1073531294.2304.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Jan 2004 19:08:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-07 at 17:20, Jesper Juhl wrote:
> size_t is an unsigned datatype in all archs.

There are literally hundreds of these in the code.

Compile with -W -Wall and see for yourself.


