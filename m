Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283868AbRLABT3>; Fri, 30 Nov 2001 20:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283869AbRLABTZ>; Fri, 30 Nov 2001 20:19:25 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:11278 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283868AbRLABTD>; Fri, 30 Nov 2001 20:19:03 -0500
Message-ID: <3C082FEB.98D8BE9B@zip.com.au>
Date: Fri, 30 Nov 2001 17:18:35 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Larry McVoy <lm@bitmover.com>, Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <20011130155740.I14710@work.bitmover.com> <Pine.LNX.4.40.0111301636010.1600-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On Fri, 30 Nov 2001, Larry McVoy wrote:
> 
> [ A lot of stuff Pro-Sun ]
> 
> Wait a minute.

umm..   Let's try to keep moving forward here.

Larry appears to be referring to the proposal sometimes
known as ccClusters.  I'd ask him a couple of followup questions:

Is there any precedent for the ccCluster idea, which would
increase confidence that it'll actually work?

Will it run well on existing hardware, or are changes needed?

You're assuming that our current development processes are
sufficient for development of a great 1-to-4-way kernel, and
that the biggest force against that is the introduction of
fine-grained locking.   Are you sure about this?  Do you see
ways in which the uniprocessor team can improve?

My take is that there's a sort of centralism in the kernel where
key people get atracted into mm/*.c, fs/*.c, net/most_everything
and kernel/*.c while other great wilderness of the tree (with
honourable exceptions) get moldier.  How to address that?
