Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVFEIVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVFEIVa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 04:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVFEIVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 04:21:30 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49537
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261522AbVFEIVP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 04:21:15 -0400
Subject: Re: patch] Real-Time Preemption, plist fixes
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <20050605081835.GA20981@elte.hu>
References: <1117930633.20785.239.camel@tglx.tec.linutronix.de>
	 <20050605081835.GA20981@elte.hu>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 05 Jun 2005 10:21:48 +0200
Message-Id: <1117959708.20785.245.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-05 at 10:18 +0200, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > 5. [...]
> 
> #6 looks pretty significant too:
> 
> >  unsigned plist_chprio(struct plist *plist, struct plist *pl, int new_prio)
> >  {
> > -	if (new_prio == plist->prio)
> > +	if (new_prio == pl->prio)
> >  		return 0;
> 
> right?
> 

Yes, forgot to rant about that :)

tglx


