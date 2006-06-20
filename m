Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWFTMsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWFTMsH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 08:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWFTMsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 08:48:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7363 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750709AbWFTMsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 08:48:06 -0400
Subject: Re: GFS2 and DLM
From: Steven Whitehouse <swhiteho@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060620123342.GA26579@infradead.org>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	 <20060620123342.GA26579@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 20 Jun 2006 13:55:06 +0100
Message-Id: <1150808106.3856.1380.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-06-20 at 13:33 +0100, Christoph Hellwig wrote:
> On Tue, Jun 20, 2006 at 01:17:13PM +0100, Steven Whitehouse wrote:
> > Hi,
> > 
> > Linus, Andrew suggested to me to send this pull request to you directly.
> > Please consider merging the GFS2 filesystem and DLM from (they are both
> > in the same tree for ease of testing):
> 
> Did anyone actually bother to review it?  It's huge and was in pretty
> bad shapre when I looked last time.  Also in the -mm merge writeup
> you guys said it's only scheduled for 2.6.19 so I didn't even bother
> looking at the huge mess.
> 
Well we have received a few comments from various people, so I would say
that it has been reviewed. You appeared to be happy with the iflags.h
header file which was the last set of comments that I have from you I
think. I'm sorry if we've missed something along the way but I hope
we've been quite careful to address all the issues.

My comments regarding 2.6.19 were due to one particular aspect of the
unlink() call which wasn't quite right. I didn't think at the time I
wrote that message that we'd be ready for this merge window, however
since Linus then went through a final -rc release, there was in fact
time to deal with this. I did post a follow up to clarify that a little
while back, so I'm sorry if it was a bit confusing,

Steve.


