Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWIOVcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWIOVcv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWIOVcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:32:51 -0400
Received: from opersys.com ([64.40.108.71]:63243 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932293AbWIOVcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:32:50 -0400
Message-ID: <450B1E60.7030303@opersys.com>
Date: Fri, 15 Sep 2006 17:42:56 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: jrs@us.ibm.com
CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com> <1158320406.29932.16.camel@localhost.localdomain> <Pine.LNX.4.64.0609151339190.6761@scrub.home> <1158323938.29932.23.camel@localhost.localdomain> <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain> <450AEC92.7090409@us.ibm.com> <20060915194937.GA7133@Krystal> <450B1309.9020800@us.ibm.com>
In-Reply-To: <450B1309.9020800@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jose R. Santos wrote:
> I don't really care which method is used as long as its the right tool 
> for the job.  I see several idea from LTT that could be integrated into 
> SystemTap in order to make it a one stop solution for both dynamic and 
> static tracing.  Would you care to elaborate why you think having 
> separate projects is a better solution?

We don't -- at least *I* wouldn't care, but I'm not the current
maintainer. ltt's usefulness has always been in the digested information
it can present to the user. The kernel patching part was a necessary
evil. What I object to is the depiction of dynamic tracing as solving
the need for static markup. I doesn't, and, therefore, does not
currently constitute an adequate substitute for ltt's patches. If
someone else can actually provide ltt with the events and surround
detail (timestamping and all) it needs while still providing the same
performance we currently get out of the current ltt patches, then I'd
say more power to them -- the current developers may how more relevant
things to say.

Karim

