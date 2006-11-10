Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWKJJne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWKJJne (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWKJJnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:43:33 -0500
Received: from www.osadl.org ([213.239.205.134]:16816 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932490AbWKJJnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:43:32 -0500
Subject: Re: [patch 01/19] hrtimers: state tracking
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20061110014053.5208f35e.akpm@osdl.org>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233034.182462000@cruncher.tec.linutronix.de>
	 <1163150389.3138.608.camel@laptopd505.fenrus.org>
	 <20061110014053.5208f35e.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 10:45:50 +0100
Message-Id: <1163151951.8335.192.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 01:40 -0800, Andrew Morton wrote:
> > 
> > ok so it IS a bit thing, see comment about hrtimer_is_queued() not being
> > a bit check then...
> > 
> 
> eek.  I exhaustively went over that confusion in my initial (and lengthy)
> review of these patches.
> 
> I don't think we ever saw a point-by-point reply.  What got lost?

I added comments in the defines and in the code as you requested.
Obviously not enough comments.

	tglx


