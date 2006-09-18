Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWIREDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWIREDf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 00:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWIREDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 00:03:35 -0400
Received: from opersys.com ([64.40.108.71]:24593 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751440AbWIREDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 00:03:34 -0400
Message-ID: <450E1F6F.7040401@opersys.com>
Date: Mon, 18 Sep 2006 00:24:15 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Ingo Molnar <mingo@elte.hu>,
       Karim Yaghmour <karim@opersys.com>, Nicholas Miell <nmiell@comcast.net>,
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
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy> <20060917230623.GD8791@elte.hu> <450DEEA5.7080808@opersys.com> <20060918005624.GA30835@elte.hu> <450DFFC8.5080005@opersys.com> <20060918033027.GB11894@elte.hu> <20060918035216.GF9049@thunk.org>
In-Reply-To: <20060918035216.GF9049@thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Theodore Tso wrote:
> I *think* what Karim is trying to claim is that LTT also has some
> dynamic capabilities, and isn't a pure static tracing system.  But if
> that's the case, I don't understand why LTT and SystemTap can't just
> merge and play nice together....

That's been the thrust of my intervention here. There is already a
great deal of common ground between the respective teams. There are
historical "incidents", if we want to call them as such, which
prompted such separation. There is a common desire of interfacing,
and much talk has been done on the topic. From my point of view,
I think it's fair to say that the SystemTap folks have been
particularly wary of interfacing with ltt based mainly on its
controversial heritage. If the signal *and* endorsement from kernel
developers is that SystemTap and LTTng should "play nice together",
then, I think, everything is in place to accelerate that.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
