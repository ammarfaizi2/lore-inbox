Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278404AbRJMUmx>; Sat, 13 Oct 2001 16:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278405AbRJMUmn>; Sat, 13 Oct 2001 16:42:43 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:5871
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278404AbRJMUm2>; Sat, 13 Oct 2001 16:42:28 -0400
Date: Sat, 13 Oct 2001 13:42:54 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Robert Love <rml@ufl.edu>, Andrea Arcangeli <andrea@suse.de>,
        safemode <safemode@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011013134254.A28547@mikef-linux.matchmail.com>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, Robert Love <rml@ufl.edu>,
	Andrea Arcangeli <andrea@suse.de>,
	safemode <safemode@speakeasy.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org> <20011010031803.F8384@athlon.random> <20011010020935.50DEF1E756@Cantor.suse.de> <20011010043003.C726@athlon.random> <1002681480.1044.67.camel@phantasy> <20011012132220.B35@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011012132220.B35@toy.ucw.cz>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 01:22:20PM +0000, Pavel Machek wrote:
> Hi!
> 
> > Now dbench (or any task) is in kernel space for too long.  The CPU time
> > xmms needs will of course still be given, but _too late_.  Its just not
> > a cpu resource problem, its a timing problem.  xmms needs x units of CPU
> > every y units of time.  Just getting the x whenever is not enough.
> 
> Yep, with
> 
> x = 60msec
> y = 600msec
>
> So you can give it time up to 540msec late with no drop-outs.
> 

How fast was the processor/memory on the system that produced these numbers?

