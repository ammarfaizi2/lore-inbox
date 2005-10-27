Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbVJ0T5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbVJ0T5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 15:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbVJ0T5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 15:57:53 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:34543 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751573AbVJ0T5x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 15:57:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VNfhMAYGZuSmxv2FTIeCxWUUmzlvbQGKnW5/JGMDHpQ/UpBqOHANkdgsBSJZSuvdqavHFyufAUqZz4ZkJ6ZeITuxbG2jA/ZQGUxUXV43LJzi7LW4An0/YClCwzjpmD8mk3LRQ/jN4DY+3pwZjaCPrTRw+gz2HSsiSMG4aflZiLo=
Message-ID: <3aa654a40510271257t62d2fd82n5f2bcbcae2bcba9d@mail.gmail.com>
Date: Thu, 27 Oct 2005 12:57:50 -0700
From: Avuton Olrich <avuton@gmail.com>
To: Patrick McFarland <diablod3@gmail.com>
Subject: Re: Overruns are killing my recordings.
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200510271528.28919.diablod3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3aa654a40510271212j13e0843s9de81c02f4e766ac@mail.gmail.com>
	 <200510271528.28919.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Patrick McFarland <diablod3@gmail.com> wrote:
> On Thursday 27 October 2005 03:12 pm, you wrote:
> > Hello,
> >
> > I've been plagued by overruns, I know it's probably linux device
> > driver issues, but wanted to see if anyone could possibly help me find
> > the heart of the issue:
> >
> > I have ecasound output (at bottom) to show that it's getting
> > interrupted for up to 6 seconds, and all I really need to know is how
> > I figure out what the problem device driver is, so I can file a more
> > specific bug.
>
> I don't know if ecasound uses jack or not, but jack should be set to use
> realtime mode. Without realtime, kiss sane low latency auto-input/output
> goodbye.

ecasound utilizes jack if it's on, which I don't really need so I
don't run it, but it is taking advantage of SCHED_FIFO. But truely
this is not what I'm trying to get to. I have something in this
computer that is interrupting everything +/- 6 seconds and I'd like to
find out what it is, I'm really just not sure the best way to find out
what the 'offender' is.

thanks,
avuton
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
