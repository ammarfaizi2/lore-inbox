Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278200AbRJRXQO>; Thu, 18 Oct 2001 19:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278203AbRJRXPy>; Thu, 18 Oct 2001 19:15:54 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:33008
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278200AbRJRXPo>; Thu, 18 Oct 2001 19:15:44 -0400
Date: Thu, 18 Oct 2001 16:16:07 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: martin sepulveda <msepulveda@joydivision.com.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: load 1 at idle, 2.4.12-ac3
Message-ID: <20011018161607.D2467@mikef-linux.matchmail.com>
Mail-Followup-To: martin sepulveda <msepulveda@joydivision.com.ar>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011016135322.02ed0f97.martin@joydivision.com.ar> <20011016140041.2f26c95c.msepulveda@joydivision.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011016140041.2f26c95c.msepulveda@joydivision.com.ar>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2001 at 02:00:41PM -0300, martin sepulveda wrote:
> forget it!
> i've found what it was, and it is certainly *not* the kernel :)
> 
> thanks anyway, and sorry
> 

What was it?  A process stuck in D state?  Something like dist.net or seti?

Reminds me of recently when my X server (a couple days ago from
debian-unstable) cought a memory leak, and my system was swapping like
crazy.  I thought it was something to do with the shmem problem I found a
while back, but I looked at /proc/meminfo and no errors with shmem.  Finally
I checked top...

Unfortunately, the OOM killer killed a few things, all except for my X
server that was causing the problem.

Mike
