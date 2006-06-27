Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbWF0HMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbWF0HMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWF0HMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:12:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7350 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932549AbWF0HML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:12:11 -0400
Date: Tue, 27 Jun 2006 09:07:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060627070720.GA29949@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623144928.GA32694@infradead.org> <20060626200300.GA15424@elte.hu> <20060627063339.GA27938@elte.hu> <1151390601.2879.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151390601.2879.16.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> > Btw., i have just taken a 5 minute tour into XFS, and i found at 
> > least 5 other problems with the XFS code that are similar in nature 
> > to the ones you pointed out.
> 
> that's no reason to merge even more junk

the GFS2 ones were immediately addressed, 28 minutes and 27 seconds 
after they were pointed out:

  Date: Fri, 23 Jun 2006 15:57:56 +0100
  From: Christoph Hellwig <hch@infradead.org>
  Subject: Re: GFS2 and DLM

  Date: Fri, 23 Jun 2006 16:26:23 +0100
  From: Steven Whitehouse <swhiteho@redhat.com>
  Subject: Re: GFS2 and DLM

> > (mostly useless wrappers around Linux functionality) Isnt this whole 
> > episode highly hypocritic to begin with?
> 
> lets not start calling names please...

well, i guess it's way too late for that:

> > Christoph Hellwig wrote:
> > > Did anyone actually bother to review it?  It's huge and was in 
> > > pretty bad shapre when I looked last time.  Also in the -mm merge 
> > > writeup you guys said it's only scheduled for 2.6.19 so I didn't 
> > > even bother looking at the huge mess.

:-)

	Ingo
