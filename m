Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131140AbRCWOw7>; Fri, 23 Mar 2001 09:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131151AbRCWOww>; Fri, 23 Mar 2001 09:52:52 -0500
Received: from [166.70.28.69] ([166.70.28.69]:63544 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S131140AbRCWOwj>;
	Fri, 23 Mar 2001 09:52:39 -0500
To: Guest section DW <dwguest@win.tue.nl>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Michael Peddemors <michael@linuxmagic.com>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010323015358Z129164-406+3041@vger.kernel.org> <Pine.LNX.4.21.0103230403370.29682-100000@imladris.rielhome.conectiva> <20010323122815.A6428@win.tue.nl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Mar 2001 07:50:25 -0700
In-Reply-To: Guest section DW's message of "Fri, 23 Mar 2001 12:28:15 +0100"
Message-ID: <m1hf0k1qvi.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guest section DW <dwguest@win.tue.nl> writes:

> On Fri, Mar 23, 2001 at 04:04:09AM -0300, Rik van Riel wrote:
> > On 22 Mar 2001, Michael Peddemors wrote:
> > 
> > > Here, Here.. killing qmail on a server who's sole task is running mail
> > > doesn't seem to make much sense either..
> > 
> > I won't defend the current OOM killing code.
> > 
> > Instead, I'm asking everybody who's unhappy with the
> > current code to come up with something better.
> 
> To a murderer: "Why did you kill that old lady?"
> Reply: "I won't defend that deed, but who else should I have killed?"

> 
> Andries - getting more and more unhappy with OOM
> 
> Mar 23 11:48:49 mette kernel: Out of Memory: Killed process 2019 (emacs).
> Mar 23 11:48:49 mette kernel: Out of Memory: Killed process 1407 (emacs).
> Mar 23 11:48:50 mette kernel: Out of Memory: Killed process 1495 (emacs).
> Mar 23 11:48:50 mette kernel: Out of Memory: Killed process 2800 (rpm).
> 
> [yes, that was rpm growing too large, taking a few emacs sessions]
> [2.4.2]

Let me get this straight you don't have enough swap for your workload?
And you don't have per process limits on root by default?

So you are complaining about the OOM killer?  

Eric
