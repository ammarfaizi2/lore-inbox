Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbULOAS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbULOAS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbULOARO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:17:14 -0500
Received: from smtp108.mail.sc5.yahoo.com ([66.163.170.6]:29583 "HELO
	smtp108.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261789AbULNXag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:30:36 -0500
Subject: Re: [PATCH] fix spurious OOM kills
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Martin =?iso-8859-2?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>,
       tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       piggin@cyberone.com.au, chris@tebibyte.org,
       marcelo.tosatti@cyclades.com, andrea@novell.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <20041214173858.GJ16322@dualathlon.random>
References: <419F2AB4.30401@ribosome.natur.cuni.cz>
	 <1100957349.2635.213.camel@thomas>
	 <419FB4CD.7090601@ribosome.natur.cuni.cz> <1101037999.23692.5.camel@thomas>
	 <41A08765.7030402@ribosome.natur.cuni.cz>
	 <1101045469.23692.16.camel@thomas>
	 <1101120922.19380.17.camel@tglx.tec.linutronix.de>
	 <41A2E98E.7090109@ribosome.natur.cuni.cz>
	 <1101205649.3888.6.camel@tglx.tec.linutronix.de>
	 <41BF0F0D.4000408@ribosome.natur.cuni.cz>
	 <20041214173858.GJ16322@dualathlon.random>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Dec 2004 10:30:18 +1100
Message-Id: <1103067018.5420.37.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 18:38 +0100, Andrea Arcangeli wrote:
> On Tue, Dec 14, 2004 at 05:04:29PM +0100, Martin MOKREJŠ wrote:
> > I see the machine a lot less responsive when it starts swapping
> > compared to 2.6.10-rc2-mm3. For example, just moving mouse between
> > windows takes some 10-12 seconds to fvwm2 to re-focus to another xterm
> > window.
> 
> I don't know exactly what's the issue here, but the oom fixes we
> developed cannot change anything until you see the first printk in the
> logs (the printk tells the admin the machine reached oom).
> 
> So slowdowns during paging can be discussed separately from the oom
> killer issues.

There was another reported slowdown for 2.6.10-rc3 in another
thread too. It is a bit odd because nothing much has changed
in the scanner.

Was there some swap-token (or can anyone think of any relevant)
changes recently?

Nick


