Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbVAKKgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVAKKgk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVAKKgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:36:40 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:25234
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262664AbVAKKgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:36:38 -0500
Subject: Re: User space out of memory approach
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Edjard Souza Mota <edjard@gmail.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <4d6522b905011102003cddca9@mail.gmail.com>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <4d6522b905011101202918f361@mail.gmail.com>
	 <1105435846.17853.85.camel@tglx.tec.linutronix.de>
	 <4d6522b905011102003cddca9@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 11:36:37 +0100
Message-Id: <1105439797.17853.94.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 12:00 +0200, Edjard Souza Mota wrote:
> Hi,
> 
> > > > > 1) ranking for the most likely culprits only starts when memory consumption
> > > > >     gets close to the red zone (for example 98% or something like that).
> > 
> > We do the ranking only in the oom situation, so what's your point ?
> 
> The point is that kernel doesn't need to keep watching the memory space
> every time a process needs memory. Only when memory is close this red zone.

Oh, I see. The mechanism which is doing memory management must not be
aware of the resources which it is managing ? Am I missing a point ?

tglx



