Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279928AbRJ3Lqn>; Tue, 30 Oct 2001 06:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279929AbRJ3Lq0>; Tue, 30 Oct 2001 06:46:26 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30191
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279927AbRJ3Lp5>; Tue, 30 Oct 2001 06:45:57 -0500
Date: Tue, 30 Oct 2001 03:46:23 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: need help interpreting 'free' output.
Message-ID: <20011030034623.C21884@mikef-linux.matchmail.com>
Mail-Followup-To: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200110301132.MAA22471@lambik.cc.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110301132.MAA22471@lambik.cc.kuleuven.ac.be>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 12:32:52PM +0100, Frank Dekervel wrote:
> so now there is 220 meg used memory right ?
> and the memory is definitely used, because as soon as i start a memory hog 
> the system hits swap ...
> 
> so what am i missing here ?
> should i provide more info about my kernel configuration ? vmstat numbers ?
> 

Ahh, are you a new convert from a 2.2 kernel?

In 2.4 the kernel will swap out much earlier to make room for the running
programs, and disk cache.  This is normal.

Earlier 2.4 kernels didn't do so well, but I won't go into detail because
there is already enough about that in the archives...

When you watch vmstat, if you see a lot of swapping traffic without much
good reason, then you should probably report something...

Mike
