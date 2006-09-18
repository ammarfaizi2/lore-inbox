Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWIRDwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWIRDwd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 23:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWIRDwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 23:52:33 -0400
Received: from thunk.org ([69.25.196.29]:32951 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751400AbWIRDwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 23:52:32 -0400
Date: Sun, 17 Sep 2006 23:52:17 -0400
From: Theodore Tso <tytso@mit.edu>
To: Ingo Molnar <mingo@elte.hu>
Cc: Karim Yaghmour <karim@opersys.com>, Nicholas Miell <nmiell@comcast.net>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918035216.GF9049@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Ingo Molnar <mingo@elte.hu>,
	Karim Yaghmour <karim@opersys.com>,
	Nicholas Miell <nmiell@comcast.net>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
	Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
	Tom Zanussi <zanussi@us.ibm.com>,
	Richard J Moore <richardj_moore@uk.ibm.com>,
	"Frank Ch. Eigler" <fche@redhat.com>,
	Michel Dagenais <michel.dagenais@polymtl.ca>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	Christoph Hellwig <hch@infradead.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	William Cohen <wcohen@redhat.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy> <20060917230623.GD8791@elte.hu> <450DEEA5.7080808@opersys.com> <20060918005624.GA30835@elte.hu> <450DFFC8.5080005@opersys.com> <20060918033027.GB11894@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918033027.GB11894@elte.hu>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 05:30:27AM +0200, Ingo Molnar wrote:
> Amazing! So the trace data provided by those removed static markups 
> (which were moved into dynamic scripts and are thus still fully 
> available to dynamic tracers) are still available to LTT users? How is 
> that possible, via quantum tunneling perhaps? ;-)

I *think* what Karim is trying to claim is that LTT also has some
dynamic capabilities, and isn't a pure static tracing system.  But if
that's the case, I don't understand why LTT and SystemTap can't just
merge and play nice together....

						- Ted
