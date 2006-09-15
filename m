Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWIOMkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWIOMkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 08:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWIOMkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 08:40:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7844 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751329AbWIOMkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 08:40:11 -0400
Date: Fri, 15 Sep 2006 14:39:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <1158323938.29932.23.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609151425180.6761@scrub.home>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
  <Pine.LNX.4.64.0609141537120.6762@scrub.home>  <20060914135548.GA24393@elte.hu>
  <Pine.LNX.4.64.0609141623570.6761@scrub.home>  <20060914171320.GB1105@elte.hu>
  <Pine.LNX.4.64.0609141935080.6761@scrub.home>  <20060914181557.GA22469@elte.hu>
 <4509B03A.3070504@am.sony.com>  <1158320406.29932.16.camel@localhost.localdomain>
  <Pine.LNX.4.64.0609151339190.6761@scrub.home> <1158323938.29932.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Sep 2006, Alan Cox wrote:

> Ar Gwe, 2006-09-15 am 13:46 +0200, ysgrifennodd Roman Zippel:
> > > That misses the entire point. If you have dynamic tracepoints you don't
> > > have any static tracepoints to maintain because you don't need them.
> > 
> > This assumes dynamic tracepoints are generally available, which is wrong.
> 
> Wrong in what sense, you don't have them implemented or your
> architecture is mindbogglingly braindead you can't implement them ?
> 
> > This assumes that dynamic tracepoints can't benefit from static source 
> > annotations, which is also wrong.
> 
> gcc -g produces extensive annotations which are then usably by many
> tools other than gdb.

Both points have very strong consequences regarding complexity. Why do you 
want to deny me the choice to use something simple, especially since both 
solutions are not mutually exclusive and can even complement each other? 
What's the point in forcing everyone to use a single solution?

bye, Roman
