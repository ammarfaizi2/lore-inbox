Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275798AbRJFWqn>; Sat, 6 Oct 2001 18:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275808AbRJFWqf>; Sat, 6 Oct 2001 18:46:35 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:55542
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S275798AbRJFWqV>; Sat, 6 Oct 2001 18:46:21 -0400
Date: Sat, 6 Oct 2001 15:46:46 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: low-latency patches
Message-ID: <20011006154646.D2625@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011006010519.A749@draal.physics.wisc.edu> <1002407812.1915.21.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1002407812.1915.21.camel@phantasy>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2001 at 06:36:49PM -0400, Robert Love wrote:
> On Sat, 2001-10-06 at 02:05, Bob McElrath wrote:
> > 3) Is there a possibility that either of these will make it to non-x86
> >     platforms?  (for me: alpha)  The second patch looks like it would
> >     straightforwardly work on any arch, but the config.in for it is only in
> >     arch/i386.  Robert Love's patches would need some arch-specific asm...
> 
> Andrew's patch should work fine on all platforms, although I think the
> configure statement is in the processor section so you will need to move
> it to arch/alpha/config.in
> 
> The preemption patch has a small amount of arch-independent code but we
> are working on supporting all architectures.  2.5...
> 

If you decide to provide support for PPC32 I'd be happy to test it on top of
a benh or bitkeeper kernel tree.

Mike
