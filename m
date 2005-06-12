Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVFLP2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVFLP2v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVFLP2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:28:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52213 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261617AbVFLP2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:28:39 -0400
Date: Sun, 12 Jun 2005 08:28:25 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, Esben Nielsen <simlo@phys.au.dk>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <20050612065733.GA6997@elte.hu>
Message-ID: <Pine.LNX.4.10.10506120827260.7591-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 Jun 2005, Ingo Molnar wrote:

> x86 is actually a 'worst-case', because it has one of the cheapest CPU 
> level cli/sti implementations. Usually it's the hard-local_irq_disable() 
> overhead on non-x86 platforms that is a problem. (ARM iirc) So in this 
> sense the soft-flag should be a win on most sane architectures.


My original port of this was on ARM , and I didn't notice a massive slow
down, or anything . I imagine it can't be unbearable. 

Daniel

