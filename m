Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263658AbRFKTjB>; Mon, 11 Jun 2001 15:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263649AbRFKTiv>; Mon, 11 Jun 2001 15:38:51 -0400
Received: from m215-mp1-cvx1a.col.ntl.com ([213.104.68.215]:27274 "EHLO
	[213.104.68.215]") by vger.kernel.org with ESMTP id <S263634AbRFKTii>;
	Mon, 11 Jun 2001 15:38:38 -0400
To: Jeff Golds <jgolds@resilience.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with arch/i386/kernel/apm.c
In-Reply-To: <3B25068B.53F2968A@resilience.com>
From: John Fremlin <vii@users.sourceforge.net>
Date: 11 Jun 2001 20:37:58 +0100
In-Reply-To: <3B25068B.53F2968A@resilience.com> (Jeff Golds's message of "Mon, 11 Jun 2001 10:57:31 -0700")
Message-ID: <m266e2lsdl.fsf@boreas.yi.org.>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Jeff Golds <jgolds@resilience.com> writes:
[...]

> Please let me know if this is correct, I can provide a simple patch
> if needed.  What I am really desiring to know is if there are any
> devices that depend on the apm::send_event(APM_NORMAL_RESUME)
> happening while interrupts are disabled.

Yes, USB host controllers

-- 

	http://ape.n3.net
