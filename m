Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269344AbUINNXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269344AbUINNXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 09:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269371AbUINNVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 09:21:38 -0400
Received: from colin2.muc.de ([193.149.48.15]:28165 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S269344AbUINNU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 09:20:56 -0400
Date: 14 Sep 2004 15:20:55 +0200
Date: Tue, 14 Sep 2004 15:20:55 +0200
From: Andi Kleen <ak@muc.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move domain setup and add dual core support.
Message-ID: <20040914132055.GA79737@muc.de>
References: <m3vfeigs5b.fsf@averell.firstfloor.org> <4146EB80.9090801@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4146EB80.9090801@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 11:00:48PM +1000, Nick Piggin wrote:
> Andi Kleen wrote:
> 
> >Patch is for 2.6.9rc1-bk19. It's much smaller than it looks,
> >most of it is just moving code from sched.c to sched-domains.h
> >
> 
> OK, I guess this should be alright... but it will clash badly
> with the stuff in -mm, which really needs to get in.

Ok, I will redo it.

But I would like to have the CMP patch soon in mainline for 2.6.9. Are 
the patches in mm scheduled to be soon in mainline? 
> 
> And your patch will be much smaller because most of the moving
> is done for you.

Where is it moved to? 

-Andi
