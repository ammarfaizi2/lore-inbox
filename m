Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265946AbRFZISu>; Tue, 26 Jun 2001 04:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265945AbRFZISl>; Tue, 26 Jun 2001 04:18:41 -0400
Received: from hacksaw.org ([216.41.5.170]:18621 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S265944AbRFZISf>; Tue, 26 Jun 2001 04:18:35 -0400
Message-Id: <200106260818.f5Q8ILE15448@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.3
To: Thomas Pornin <Thomas.Pornin@ens.fr>, linux-kernel@vger.kernel.org
Subject: Re: GCC3.0 Produce REALLY slower code! 
In-Reply-To: Your message of "Tue, 26 Jun 2001 09:40:16 +0200."
             <20010626094016.A5899@bolet.ens.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jun 2001 04:18:21 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Apart from questions of optimization, compiling the same code with two
>different compilers is a very good way to find bugs, both in the code
>and in the compilers.

I agree that this is a workable idea. On the other hand, I'd bet Linus would 
put that idea right up there with shipping a debugger in kernel.

If you need to use tricks like that to find bugs, you might not understand 
your code as well as you should.

The optimization angle is an important one. I'd like to see intel's 
optimizations tested against the kernel, *and then released in gcc*, or 
something specialized like pgcc. (Anyone know if pgcc ever compiled a good 
kernel that was notably faster?)

Overall, though, I'd bet such optimizations would give no more than a few 
percentage points of speed overall. The big gains are to be had by serious 
redesign like the cache change or the zero copy stuff.

When your design is mediocre, an optimizing compiler makes the the wrong idea 
faster.

