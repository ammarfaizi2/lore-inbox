Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279650AbRJ2X5a>; Mon, 29 Oct 2001 18:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279649AbRJ2X5U>; Mon, 29 Oct 2001 18:57:20 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:49956 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279653AbRJ2X5H>; Mon, 29 Oct 2001 18:57:07 -0500
Date: Mon, 29 Oct 2001 18:57:44 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011029185743.M25434@redhat.com>
In-Reply-To: <20011029184821.K25434@redhat.com> <20011029.155056.23033599.davem@redhat.com> <20011029185158.L25434@redhat.com> <20011029.155559.64018347.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011029.155559.64018347.davem@redhat.com>; from davem@redhat.com on Mon, Oct 29, 2001 at 03:55:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 03:55:59PM -0800, David S. Miller wrote:
> Doing range flushes is not the answer.   It is going to be about
> the same cost as doing per-page flushes.
> 
> The cost is doing the cross calls at all, not the granularity in which
> we do them.
> 
> You're refusing to do any work to prove whether your case matters
> at all in real life, and you're calling other people assholes for
> asking that you do so.

See Paul's message.  ia64 does the same thing with hardware walked hashed 
page tables.  Now, do you want to pay for the 2 days of time you want me 
to commit to investigating something which is obvious to me?  I don't think 
so.

		-ben
