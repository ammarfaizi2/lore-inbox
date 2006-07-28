Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161194AbWG1Roy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbWG1Roy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161199AbWG1Roy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:44:54 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:47527 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161194AbWG1Rox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:44:53 -0400
Date: Fri, 28 Jul 2006 20:44:49 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Andrew Morton <akpm@osdl.org>, trivial@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use BUG_ON(foo) instead of "if (foo) BUG()" in include/asm-i386/dma-mapping.h
Message-ID: <20060728174449.GA11046@rhun.ibm.com>
References: <200607280928.54306.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607280928.54306.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 09:28:49AM +0200, Rolf Eike Beer wrote:

> We have BUG_ON() right for this, don't we?

Even better, we have valid_dma_direction() in x86-64. Care to move it
to generic code and update i386 to use it?

Cheers,
Muli


