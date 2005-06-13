Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVFMUSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVFMUSw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVFMUSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:18:14 -0400
Received: from opersys.com ([64.40.108.71]:64524 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261255AbVFMUQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:16:39 -0400
Message-ID: <42ADEC0E.4020907@opersys.com>
Date: Mon, 13 Jun 2005 16:26:54 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: dwalker@mvista.com
CC: paulmck@us.ibm.com, Andrea Arcangeli <andrea@suse.de>,
       Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <20050610223724.GA20853@nietzsche.lynx.com>	 <20050610225231.GF6564@g5.random>	 <20050610230836.GD21618@nietzsche.lynx.com>	 <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com>	 <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com>	 <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com>	 <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com>	 <42ADE334.4030002@opersys.com> <1118693033.2725.21.camel@dhcp153.mvista.com>
In-Reply-To: <1118693033.2725.21.camel@dhcp153.mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel Walker wrote:
> I think this is mistake. Projects that create separation like this are
> begging for the community to reject them. I see this as a design for
> one, instead of design for many mistake. From what I've seen, a project
> would want to do as much clean integration as possible.

I understand what you're saying, but based on the feedback
PREEMPT_RT has gotten up until now, and now outright suggestions
that the debate is not even relevant to the LKML, I think that
some people are trying to give those interested a hint: integration
with mainline code is NOT on the agenda.

Some may want to continue trying to force-feed mainstream
maintainers. I can't stop anyone from trying, that's for sure.
However, I think what I'm suggesting is a reasonable compromise:
mainstream maintainers don't need to care about RT on a day-to-
day basis and the RT folks get to be part of mainline.

That said, please make sure you've carefully read through what
I suggest. I'm not saying that everything inside the kernel needs
to be duplicated. I'm saying that what add-ons are should be
separate. For example, like I was first saying, headers in
include/linux-hrt would point back to include/linux-srt where
appropriate.

And like I said earlier, this suggestion would need to be refined.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
