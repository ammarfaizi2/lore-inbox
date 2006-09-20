Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWITNcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWITNcc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWITNcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:32:32 -0400
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:46507 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751286AbWITNcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:32:31 -0400
Date: Wed, 20 Sep 2006 09:32:29 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Ingo Molnar <mingo@elte.hu>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060920133229.GA17032@Krystal>
References: <20060918234502.GA197@Krystal> <4511401B.4070809@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <4511401B.4070809@hitachi.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 09:30:18 up 28 days, 10:38,  2 users,  load average: 0.22, 0.28, 0.20
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Masami Hiramatsu (masami.hiramatsu.pt@hitachi.com) wrote:
> Hi,
> 
> Mathieu Desnoyers wrote:
> > Hello,
> > 
> > Following this huge discussion thread, I tried to come with a marker mechanism
> > (which is something everyone seems to agree that is a necessity) that would be
> > useful to each kind of tracing (dynamic and static) (concerned projects :
> > SystemTAP, LKET, LKST, LTTng) and even combinations of those. Religious
> > considerations aside, I really think that this kind of generic markup is
> > necessary to fill *everybody*'s need. If I forgot about a specific genericity
> > aspect, please tell me.
> > 
> > I take for agreed that both static and dynamic tracing are useful for different
> > needs and that a full markup must support both and combinations, letting the
> > user or the distribution choose.
> 
> Basically, I like this static marker concept.
> But I wonder why wouldn't you use the architecture-independent
> marker which SystemTap already supports.
> If we use NOPs, it highly depends on architecture, and is hard
> to port.
> 

Hi Masami,

Are you talking about the marker presented by Frank in his OLS paper (
void dest() = NULL; if(dest) dest()) ? I think it is a very good idea to use it
instead of nops.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
