Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWIRAwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWIRAwI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbWIRAwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:52:07 -0400
Received: from opersys.com ([64.40.108.71]:2576 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S965185AbWIRAwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:52:05 -0400
Message-ID: <450DF28E.3050101@opersys.com>
Date: Sun, 17 Sep 2006 21:12:46 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu>
In-Reply-To: <20060918000703.GA22752@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> yeah. If you look at the API suggestions i made, they are such. There 
> can be differences though to 'static tracepoints used by static 
> tracers': for example there's no need to 'mark' a static variable, 
> because dynamic tracers have access to it - while a static tracer would 
> have to pass it into its trace-event function call.

That has been your own personal experience of such things. Fortunately
by now you've provided to casual readers ample proof that such
experience is but limited and therefore misleading. The fact of the
matter is that *mechanisms* do not "magically" know what detail is
necessary for a given event or how to interpret it: only *markup* does
that.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
