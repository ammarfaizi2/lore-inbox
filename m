Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbRE1XrG>; Mon, 28 May 2001 19:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbRE1Xq4>; Mon, 28 May 2001 19:46:56 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:10252 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S261800AbRE1Xqj>; Mon, 28 May 2001 19:46:39 -0400
Date: Tue, 29 May 2001 01:46:35 +0200
From: Kurt Roeckx <Q@ping.be>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Vadim Lebedev <vlebedev@aplio.fr>, linux-kernel@vger.kernel.org
Subject: Re: Potenitial security hole in the kernel
Message-ID: <20010529014635.A3499@ping.be>
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP> <20010529001256.F9203@flint.arm.linux.org.uk> <20010529013030.A3381@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <20010529013030.A3381@ping.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 01:30:30AM +0200, Kurt Roeckx wrote:
> You should never "return" from userspace to kernelspace.  The
> only way to go from user space to kernel space should be by using
> a system call.

If you were able to return to kernel space, it already means
you're running as kernel in the first place.  There is no reason
to even do the return in the first place.


Kurt

