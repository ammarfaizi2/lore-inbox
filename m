Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWFUUb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWFUUb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWFUUb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:31:58 -0400
Received: from www.tglx.de ([213.239.205.147]:28116 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030233AbWFUUb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:31:57 -0400
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Esben Nielsen <nielsen.esben@gogglemail.com>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606212226291.7939@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>
	 <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
	 <1150816429.6780.222.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
	 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com>
	 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
	 <1150824092.6780.255.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
	 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com>
	 <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain>
	 <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain>
	 <1150907165.25491.4.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606212226291.7939@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 22:33:27 +0200
Message-Id: <1150922007.25491.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 22:29 +0100, Esben Nielsen wrote:
> > Find an version against the code in -mm below. Not too much tested yet.
>
> What if setscheduler is called from interrup context as in the hrt timers?

It simply gets stuff going, nothing else. 

	tglx


