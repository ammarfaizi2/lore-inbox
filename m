Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbVHZO1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbVHZO1W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 10:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbVHZO1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 10:27:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18933 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751590AbVHZO1V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 10:27:21 -0400
Subject: Re: 2.6.13-rc7-rt1
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20050826063147.GD17783@elte.hu>
References: <20050825062651.GA26781@elte.hu>
	 <1124984208.25139.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050825174515.GA31215@elte.hu>
	 <1125005724.10901.5.camel@dhcp153.mvista.com>
	 <20050826063147.GD17783@elte.hu>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 07:27:12 -0700
Message-Id: <1125066432.7896.9.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 08:31 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > On Thu, 2005-08-25 at 19:45 +0200, Ingo Molnar wrote:
> > > * Daniel Walker <dwalker@mvista.com> wrote:
> > > 
> > > > Does anyone have x86_64 working in PREEMPT_RT ?
> > > 
> > > builds fine, but doesnt seem to boot at the moment. Havent investigated 
> > > yet.
> > 
> > I tested an em64t , and it hung during boot .. But this patched fixed 
> > it, does it do anything for you?
> 
> where does this patch come from (is it from upstream perhaps?), and what 
> does it fix?

I made it , so it comes from me. One of my cpus appeared to be going
idle prior to the idle thread being fully setup for that cpu . So it's
an attempt to fix that. My system booted (in PREEMPT_RT) after I applied
it, which is why I sent it to you ..

Daniel

