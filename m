Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313350AbSC2FKw>; Fri, 29 Mar 2002 00:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313351AbSC2FKn>; Fri, 29 Mar 2002 00:10:43 -0500
Received: from are.twiddle.net ([64.81.246.98]:3219 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S313350AbSC2FK2>;
	Fri, 29 Mar 2002 00:10:28 -0500
Date: Thu, 28 Mar 2002 21:10:25 -0800
From: Richard Henderson <rth@twiddle.net>
To: Michal Moskal <malekith@pld.org.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-3.1 ffs problem, kernel 2.4.18
Message-ID: <20020328211025.A30037@twiddle.net>
Mail-Followup-To: Michal Moskal <malekith@pld.org.pl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020320174238.GA13533@ep09.kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 06:42:38PM +0100, Michal Moskal wrote:
> Following patch is needed to compile linux-2.4.18 with xfs patch with
> recent gcc 3.1 snapshot.

What is the failure mode?

> It is clearly bug in linux includes (they use asm code unconditionally,
> even on constants, ...

So?  I don't see that that's a *bug* at all.  A missed optimization
opportunity yes, bug no.


> Beside this linux-2.4.18 compiled with gcc-3.1 20020311 works fine for
> me.

Thanks for testing though.


r~
