Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269452AbUINP72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269452AbUINP72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269438AbUINPxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:53:40 -0400
Received: from colin2.muc.de ([193.149.48.15]:39952 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S269452AbUINPuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:50:00 -0400
Date: 14 Sep 2004 17:49:59 +0200
Date: Tue, 14 Sep 2004 17:49:59 +0200
From: Andi Kleen <ak@muc.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move domain setup and add dual core support.
Message-ID: <20040914154959.GB47507@muc.de>
References: <m3vfeigs5b.fsf@averell.firstfloor.org> <4146EB80.9090801@yahoo.com.au> <20040914132055.GA79737@muc.de> <4146F46A.6070800@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4146F46A.6070800@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> include/linux/sched.h
> 
> I know we've been trying to move stuff *out* of there, but this is
> something that actually fits. On the other hand, it is not really
> going to be used by more than a few files outside sched.c, so maybe
> it could go to its own file if anyone felt strongly about it.

I don't feel strongly about it. My main requirement is to just turn
off the SD_SHAREPOWER for dual core. I would like to do that
for 2.6.9. The more explicit tuning for dual core is not that urgent and 
work in progress.

-Andi

