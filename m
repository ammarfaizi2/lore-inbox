Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbRCYSWO>; Sun, 25 Mar 2001 13:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132148AbRCYSWE>; Sun, 25 Mar 2001 13:22:04 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:26660 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S132147AbRCYSVz>;
	Sun, 25 Mar 2001 13:21:55 -0500
Message-ID: <20010325202115.D6759@win.tue.nl>
Date: Sun, 25 Mar 2001 20:21:15 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: wichert@cistron.nl (Wichert Akkerman), linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
In-Reply-To: <UTC200103251231.OAA10795.aeb@vlet.cwi.nl> <99l375$rn5$1@picard.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <99l375$rn5$1@picard.cistron.nl>; from Wichert Akkerman on Sun, Mar 25, 2001 at 05:35:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2001 at 05:35:01PM +0200, Wichert Akkerman wrote:
> In article <UTC200103251231.OAA10795.aeb@vlet.cwi.nl>,
>  <Andries.Brouwer@cwi.nl> wrote:
> >a large name space allows one to omit checking what part can be
> >reused - reuse is unnecessary.
> 
> You are just delaying the problem then, at some point your uptime will
> be large enough that you have run through all 64bit pids for example.
> 
> Wichert.

Yes indeed. If my box, after continually spawning 1000000000 processes
per second for 500 years crashes because pid_t overflows, I'll think
about whether I should put the test back in, or should upgrade to a
128-bit machine.

Andries
