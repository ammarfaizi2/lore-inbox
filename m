Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279643AbRJ2Xzk>; Mon, 29 Oct 2001 18:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279645AbRJ2Xza>; Mon, 29 Oct 2001 18:55:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12180 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279643AbRJ2XzZ>;
	Mon, 29 Oct 2001 18:55:25 -0500
Date: Mon, 29 Oct 2001 15:55:59 -0800 (PST)
Message-Id: <20011029.155559.64018347.davem@redhat.com>
To: bcrl@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011029185158.L25434@redhat.com>
In-Reply-To: <20011029184821.K25434@redhat.com>
	<20011029.155056.23033599.davem@redhat.com>
	<20011029185158.L25434@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Mon, 29 Oct 2001 18:51:58 -0500

   On Mon, Oct 29, 2001 at 03:50:56PM -0800, David S. Miller wrote:
   > 
   > Numbers talk, bullshit walks.
   
   There is a correct way to do this optimization.  If you're enough
   of an asshole to not care about doing it that way, great!

Doing range flushes is not the answer.   It is going to be about
the same cost as doing per-page flushes.

The cost is doing the cross calls at all, not the granularity in which
we do them.

You're refusing to do any work to prove whether your case matters
at all in real life, and you're calling other people assholes for
asking that you do so.

Franks a lot,
David S. Miller
davem@redhat.com

   
