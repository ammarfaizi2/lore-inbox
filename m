Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVCJR4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVCJR4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVCJRwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:52:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:60131 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262751AbVCJRnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:43:04 -0500
Date: Thu, 10 Mar 2005 09:44:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Greg KH <greg@kroah.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] -stable, how it's going to work.
In-Reply-To: <1110475644.12805.43.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0503100941550.2530@ppc970.osdl.org>
References: <20050309072833.GA18878@kroah.com>  <16944.6867.858907.990990@cse.unsw.edu.au>
  <20050310164312.GC16126@kroah.com> <1110475644.12805.43.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Mar 2005, Lee Revell wrote:
> 
> So just to be 100% clear, no sound with 2.6.N where the sound worked
> with 2.6.N-1 absolutely does qualify.  Right?

If you can send in a patch that fixes it in an obvious way and in less
than 100 lines of context diff, hell yes.

Remember: all the other constraints still hold. Don't fall into the trap 
of believing that "if it fixes a regression, it's for -stable". It needs 
to be _obvious_, and it needs to be small enough that bugs are unlikely.

And that "small enough" is really important. Bugs do happen. Even in 
"obvious" patches. The whole _point_ of -stable is to try to make them 
less likely, and the strict constraints are very much a part of that.

		Linus
