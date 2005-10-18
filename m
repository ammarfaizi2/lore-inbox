Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVJRLwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVJRLwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 07:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVJRLwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 07:52:08 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:45725 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750711AbVJRLwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 07:52:07 -0400
Date: Tue, 18 Oct 2005 13:52:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Olaf Hering <olh@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disable PREEMPT_BKL per default
Message-ID: <20051018115229.GA757@elte.hu>
References: <20051016154108.25735ee3.akpm@osdl.org> <20051018074511.GA13182@suse.de> <1129622010.2779.6.camel@laptopd505.fenrus.org> <20051018084706.GA14666@suse.de> <1129625881.2779.12.camel@laptopd505.fenrus.org> <20051018111242.GC17971@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018111242.GC17971@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Olaf Hering <olh@suse.de> wrote:

> > > Its disabled in our configs.
> > 
> > any particular reason for that? Eg are there any known or suspected
> > issues with this?
> 
> I have no idea. Maybe it was the general 'preempt isnt right' move.

that's not a reason to apply your patch that default-disables the 
feature on the upstream kernel. Distributors can pick whichever flavor 
they want. E.g. Fedora rawhide has PREEMPT_BKL enabled.

i'm fine with removing the .config option for 2.6.15.

	Ingo
