Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVFNCgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVFNCgK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 22:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVFNCgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 22:36:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14374 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261343AbVFNCgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 22:36:02 -0400
Date: Mon, 13 Jun 2005 22:35:10 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Attempted summary of "RT patch acceptance" thread
In-reply-to: <42AE3BEB.2070309@opersys.com>
X-X-Sender: nico@localhost.localdomain
To: Karim Yaghmour <karim@opersys.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, dwalker@mvista.com, paulmck@us.ibm.com,
       Andrea Arcangeli <andrea@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, lkml <linux-kernel@vger.kernel.org>,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, Andrew Morton <akpm@osdl.org>
Message-id: <Pine.LNX.4.63.0506132204460.1667@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com>
 <42ADE334.4030002@opersys.com> <1118693033.2725.21.camel@dhcp153.mvista.com>
 <42ADEC0E.4020907@opersys.com> <1118694495.2725.32.camel@dhcp153.mvista.com>
 <42AE01EA.10905@opersys.com> <42AE04AE.8070107@opersys.com>
 <20050613221810.GA820@nietzsche.lynx.com> <42AE0875.8010001@opersys.com>
 <20050613222909.GA880@nietzsche.lynx.com> <42AE0EF8.1090509@opersys.com>
 <Pine.LNX.4.63.0506132052590.1667@localhost.localdomain>
 <42AE3BEB.2070309@opersys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2005, Karim Yaghmour wrote:

> 
> Nicolas Pitre wrote:
> > The best way to do this stuff has already been outlined by Ingo himself, 
> > and as far as I know he's still the man leading the show.
> 
> Touchy we are I see. Sorry to disappoint you, but I'm not interested
> in stealing anyone's show.  I've got my own workload thank you very
> much.

Wow...  Did I really offend you so much?

I pretty know who you are, in case you forgot that we know each other, 
and your reading into my words that I somehow might have been suggesting 
that you would do that work yourself is rather amusing.

> >  And no one 
> > objected to his strategy so far.
> 
> Objections have been voiced. Go back and read earlier postings.

I read them.  Admitedly some people are quite enthousiastic about 
PREEMPT_RT and maybe a little too anxious to see it appear into 
mainline.  This is however not INgo's case AFAICS.

> > There is just no rush.  It doesn't have to be integrated ASAP, and 
> > actually not before a while, and then certainly not in a disturbing way.  
> > Lots of things have to be cleaned up in the patch, and even in the 
> > current stock kernel for that matter, and Ingo even agreed to that.
> 
> Sorry, but go back and check who's asking for ASAP. Then go back a
> few e-mails and read back what I said:
> > So one can keep ignoring the reality of the existing clash here,
> > but it may just be that backing off a little and thinking about it
> > in less absolute integration terms would help.

Thing is that there is just no existing clash.  At least not yet.  The 
whole thing is not ready for merging as Ingo said and therefore any 
discussion on merging issues are rather premature at this point.

> > So any discussion about merging of PREEMPT_RT into mainline is simply 
> > hand waving at this point.  Let it evolve and resume this discussion 
> > when there is actually something being proposed for merging into 
> > mainline.
> 
> So in your opinion, we should all put our brains on idle until someone
> posts a patch containing the words "please apply"?

Exactly.  How often has it been said on this very list and elsewhere: 
"show me the patch"?  In other words, there is no point discussing any 
merging issues when the project leader himself says it is not ready and 
has not posted any patch labeled as merge candidate.  I somehow trust 
Ingo for posting patches when they are ready to be reviewed for 
integration into mainline +_if_ and _when_ it is time.  Until then loads 
of changes may happen in the PREEMPT_RT code randering any present 
discussion on merging rather moot.

There is no gain into getting too excited about things.
And this sentence is not directed at Karim in particular.
I'm sure the concerned people will recognize themselves.


Nicolas
