Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292281AbSBYVE5>; Mon, 25 Feb 2002 16:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292282AbSBYVEl>; Mon, 25 Feb 2002 16:04:41 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:22101 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S292281AbSBYVEU>; Mon, 25 Feb 2002 16:04:20 -0500
Date: Mon, 25 Feb 2002 14:20:14 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: marco <marco@tux.dynu.com>
Cc: suparna@in.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel support of socket async I/O
Message-ID: <20020225142013.E11675@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0202251521440.27334-100000@valeria.casa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0202251521440.27334-100000@valeria.casa>; from marco@tux.dynu.com on Mon, Feb 25, 2002 at 05:05:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 05:05:41PM +0100, marco wrote:
> Hello Benjamin and all of the guys on the lists,
> I'm pretty much interested in socket async I/O for a project at work. I
> read the document at 
...
> I also searched linux-kernel archives for some status information, but
> couldn't gain much info (other than a couple of discussion threads back in
> late 1999).
> What we need is a standard aio/thread-pool-in-sigwaitinfo architecture and
> we wouldn't like to use select/poll.
...

Recent development activity was mostly geared at raw block device and 
filesystem aio (as that's what the testers are using).  I did post patches 
for network aio, but dropped them due to time constraints.  Now that the 
most recent flurry of fixes to the aio core is complete (it's looking 
very good now), I need to get the core bits updated for 2.5 and see how 
much can be merged.  As for help, the network bits need polish and testing 
to get to the near-release quality of the rest of the code.

		-ben
