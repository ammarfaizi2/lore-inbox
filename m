Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbWIRAne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWIRAne (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbWIRAne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:43:34 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:4543 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965172AbWIRAnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:43:33 -0400
Date: Mon, 18 Sep 2006 02:43:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nicholas Miell <nmiell@comcast.net>
cc: Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
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
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
In-Reply-To: <1158538213.2471.73.camel@entropy>
Message-ID: <Pine.LNX.4.64.0609180231110.6761@scrub.home>
References: <450D182B.9060300@opersys.com>  <20060917112128.GA3170@localhost.usen.ad.jp>
  <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy> 
 <20060917230623.GD8791@elte.hu> <1158538213.2471.73.camel@entropy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 17 Sep 2006, Nicholas Miell wrote:

> Anyone know what's hard about kprobes on m68k? Roman?

A limited kprobes hack wouldn't be that difficult (but would still 
require more time than I have right now), although it would be barely 
usable with a large number of traces.
Ingo might be able to optimize kprobes on his machine to nothing, but that 
doesn't help me very much.

bye, Roman
