Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWDSOit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWDSOit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWDSOit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:38:49 -0400
Received: from THUNK.ORG ([69.25.196.29]:15825 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750800AbWDSOit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:38:49 -0400
Date: Wed, 19 Apr 2006 10:38:15 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Lee Revell <rlrevell@joe-job.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rddunlap@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
Subject: Re: irqbalance mandatory on SMP kernels?
Message-ID: <20060419143815.GH706@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Arjan van de Ven <arjan@infradead.org>,
	Erik Mouw <erik@harddisk-recovery.com>,
	Lee Revell <rlrevell@joe-job.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	"Robert M. Stockmann" <stock@stokkie.net>,
	linux-kernel@vger.kernel.org, Randy Dunlap <rddunlap@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Andre Hedrick <andre@linux-ide.org>,
	Manfred Spraul <manfreds@colorfullife.com>,
	Alan Cox <alan@redhat.com>, Kamal Deen <kamal@kdeen.net>
References: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net> <4443A6D9.6040706@mbligh.org> <1145286094.16138.22.camel@mindpipe> <20060418163539.GB10933@thunk.org> <1145384357.2976.39.camel@laptopd505.fenrus.org> <20060419124210.GB24807@harddisk-recovery.com> <1145456594.3085.42.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145456594.3085.42.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 04:23:14PM +0200, Arjan van de Ven wrote:
> as long as the irqs are spread the apaches will (on average) follow your
> irq to the right cpu. Only if you put both irqs on the same cpu you have
> an issue

Maybe I'm being stupid but I don't see how the Apache's will follow
the IRQ's to the right CPU.  I agree this would be a good thing to do,
but how does the scheduler accomplish this?

						- Ted
