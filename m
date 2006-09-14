Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWINS2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWINS2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWINS2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:28:17 -0400
Received: from opersys.com ([64.40.108.71]:57359 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1750949AbWINS2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:28:17 -0400
Message-ID: <4509A1A1.20004@opersys.com>
Date: Thu, 14 Sep 2006 14:38:25 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Michel Dagenais <michel.dagenais@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>	 <20060914135548.GA24393@elte.hu>	 <Pine.LNX.4.64.0609141623570.6761@scrub.home> <1158247596.5068.19.camel@localhost> <45099A81.8060206@yahoo.com.au>
In-Reply-To: <45099A81.8060206@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nick Piggin wrote:
> What's the huge problem with making kprobes the only option (that can't
> be fixed by doing a bit of coding)?

No offense, having been on the receiving end of this for a number
of years, one feels like he's watching a never-ending repeat of a
30second commercial where the woman is holding up a magic scrub
and says something like "Just use Mr. Scrub" and the product then
twinkles with some light music and then cut, next commercial;
except in this case, it's "Just use Kprobes" and all your
problems will go away, wink-wink!

Sorry, it's just not that straight-forward. There's a reason
why the systemtap folks got interested in the markers proposal,
they actually have to maintain a dynamic instrumentation set.
Mr. Scrub just doesn't scrub as clean as advertised, you
actually have to scrub to make the scum go away. Which goes
back to what I said elsewhere: no matter where you draw the
line someone is doing the heavy lifting. Doing it outside the
kernel only means that there's yet another piece of software
that needs to be updated before you can actually start
profiting from your new and improved kernel ...

Karim

