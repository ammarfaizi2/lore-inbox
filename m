Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVGKEIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVGKEIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 00:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVGKEIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 00:08:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:34709 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261628AbVGKEIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 00:08:52 -0400
Date: Mon, 11 Jul 2005 06:08:38 +0200
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, Zwane Mwaikambo <zwane@fsmlabs.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] i386: Per node IDT
Message-ID: <20050711040838.GC7538@bragg.suse.de>
References: <Pine.LNX.4.61.0507101617240.16055@montezuma.fsmlabs.com.suse.lists.linux.kernel> <p73eka614t7.fsf@verdi.suse.de> <1121054565.3177.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121054565.3177.2.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I would also not define it statically, but allocate it at boot time
> > in node local memory.
> 
> this is probably more tricky so I would suggest doing this in a second
> step.

Not sure it's that tricky.  Otherwise he'll waste a lot of memory.

-Andi
