Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273068AbTHFBwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 21:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273071AbTHFBwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 21:52:38 -0400
Received: from mailhost.NMT.EDU ([129.138.4.52]:32436 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id S273068AbTHFBwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 21:52:37 -0400
Date: Tue, 5 Aug 2003 19:47:24 -0600
From: Val Henson <val@nmt.edu>
To: Werner Almesberger <werner@almesberger.net>
Cc: Larry McVoy <lm@work.bitmover.com>,
       David Lang <david.lang@digitalinsight.com>,
       "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TOE brain dump
Message-ID: <20030806014724.GH11101@speare5-1-14>
References: <20030804223800.P5798@almesberger.net> <Pine.LNX.4.44.0308041841190.7534-100000@dlang.diginsite.com> <20030805015401.GA15811@work.bitmover.com> <20030804233026.R5798@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804233026.R5798@almesberger.net>
User-Agent: Mutt/1.4.1i
X-Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 11:30:27PM -0300, Werner Almesberger wrote:
> Larry McVoy wrote:
> > I'd suggest that all of you look at the fact that all of these offload 
> > card companies have ended up dieing.  I don't know of a single one that
> > made it to profitability.  Doesn't that tell you something?  What has 
> > changed that makes this a good idea?
> 
> 1) So far, most of the battle has been about data transfers.
>    Now, per-packet overhead is becoming an issue.
> 
> 2) AFAIK, they all went for designs that isolated their code
>    from the main stack. That's one thing that, IMHO, has to
>    change.
> 
> Is this enough to make TOE succeed ? I don't know.

Jeff Mogul recently wrote an interesting paper called "TCP Offload is
a Dumb Idea Whose Time Has Come":

http://www.usenix.org/events/hotos03/tech/full_papers/mogul/mogul_html/

(It's 6 pages long and in HTML - easy to read.)

After explaining why TCP offload is a dumb idea, he goes on to argue
that *if* storage area networks are replaced with switched ethernet,
and RDMA becomes popular, TCP offload might make sense for sending
data to your disks.

This is a good, short paper to read if you are interested in TOE for
any reason.

-VAL
