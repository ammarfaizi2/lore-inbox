Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbWIRBwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbWIRBwu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 21:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbWIRBwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 21:52:50 -0400
Received: from thunk.org ([69.25.196.29]:44956 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965223AbWIRBwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 21:52:49 -0400
Date: Sun, 17 Sep 2006 21:52:08 -0400
From: Theodore Tso <tytso@mit.edu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Nicholas Miell <nmiell@comcast.net>,
       Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918015208.GE9049@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
	Nicholas Miell <nmiell@comcast.net>,
	Paul Mundt <lethal@linux-sh.org>,
	Karim Yaghmour <karim@opersys.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
	Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
	Richard J Moore <richardj_moore@uk.ibm.com>,
	"Frank Ch. Eigler" <fche@redhat.com>,
	Michel Dagenais <michel.dagenais@polymtl.ca>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	Christoph Hellwig <hch@infradead.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	William Cohen <wcohen@redhat.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy> <20060917230623.GD8791@elte.hu> <Pine.LNX.4.64.0609180136340.6761@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609180136340.6761@scrub.home>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 02:05:19AM +0200, Roman Zippel wrote:
> 1. It's not that I don't want to, but I _can't_ implement kprobes and not 
> due to lack of skills, but lack of resources. (There is a subtle but 
> important difference.)

Um, given the amount of time you've spent trying to pursuade us why
you can't implement kprobes for m68k, perhaps you would have
implemented it already if you had buckled down and started coding
instead of flaming about why everyone else should bend over backwards
just because you don't have time for your arch?   :-)

						- Ted
