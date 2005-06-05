Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVFEIx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVFEIx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 04:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVFEIx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 04:53:26 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:2178
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261538AbVFEIxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 04:53:12 -0400
Subject: Re: [patch] Real-Time Preemption, plist fixes
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <20050605082616.GA26824@elte.hu>
References: <1117930633.20785.239.camel@tglx.tec.linutronix.de>
	 <20050605082616.GA26824@elte.hu>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 05 Jun 2005 10:53:44 +0200
Message-Id: <1117961624.20785.258.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-05 at 10:26 +0200, Ingo Molnar wrote:

> > Date: Sun, 05 Jun 2005 02:17:12 +0200

:)

> but i think the fundamental question remains even on Sunday mornings -
> is the plist overhead worth it? Compared to the simple sorted list we 
> exchange O(nr_RT_tasks_running) for O(nr_RT_levels_used) [which is in 
> the 1-100 range], is that a significant practical improvement? By 
> overhead i dont just mean cycle cost, but also architectural flexibility 
> and maintainability.

That was my question too. 

tglx


