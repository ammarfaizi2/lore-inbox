Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285669AbRLTAV6>; Wed, 19 Dec 2001 19:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285703AbRLTAVw>; Wed, 19 Dec 2001 19:21:52 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:8239 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285669AbRLTAVi>; Wed, 19 Dec 2001 19:21:38 -0500
Date: Wed, 19 Dec 2001 19:21:36 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011219192136.F2034@redhat.com>
In-Reply-To: <E16Gjuw-0000UT-00@starship.berlin> <Pine.LNX.4.33.0112190859050.1872-100000@penguin.transmeta.com> <20011219135708.A12608@devserv.devel.redhat.com> <20011219.161359.71089731.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011219.161359.71089731.davem@redhat.com>; from davem@redhat.com on Wed, Dec 19, 2001 at 04:13:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 04:13:59PM -0800, David S. Miller wrote:
> Now, if these few and far between people who are actually interested
> in AIO are willing to throw money at the problem to get it worked on,
> that is how the "reasonable timescale" will be arrived at.  And if
> they aren't willing to toss money at the problem, how important can it
> really be to them? :-)

People are throwing money at the problem.  We're now at a point that in 
order to provide the interested people with something they can use, we 
need some kind of way to protect their applications against calling an 
unsuspecting new mmap syscall instead of the aio syscall specified in 
the kernel they compiled against.

> Maybe, just maybe, most people simply do not care one iota about AIO.
> 
> Linux caters to the general concerns not the nooks and cranies, that
> is why it is anything but doomed.

What I'm saying is that for more people to play with it, it needs to be 
more widely available.  The set of developers that read linux-kernel and 
linux-aio aren't giving much feedback.  I do not expect the code to go 
into 2.5 at this point in time.  All I need is a set of syscall numbers 
that aren't going to change should this implementation stand up to the 
test of time.

		-ben
-- 
Fish.
