Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270349AbRHWVBX>; Thu, 23 Aug 2001 17:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270264AbRHWVBN>; Thu, 23 Aug 2001 17:01:13 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:30347
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S270373AbRHWVBC>; Thu, 23 Aug 2001 17:01:02 -0400
Date: Thu, 23 Aug 2001 14:01:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rick Hohensee <humbubba@smarty.smart.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823140111.A14302@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <200108232108.RAA21070@smarty.smart.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108232108.RAA21070@smarty.smart.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 05:08:14PM -0400, Rick Hohensee wrote:

>  In other words, a kernel build has a close correlation with actual system
> bootstrap processes, where the niceties of the interpreter-du-jour are
> irrelvant, as are the percentages or absolute numbers of people that don't
> do hard bootstrapping of anything. This is the aspect of low-level code
> that utilities used in a kernel build should adhere to, no gratuitous
> dependancies. Linux is and always has been hard enough to bring up,
> needing as it does a C compiler that needs a C compiler. Somehow the
> cuteness of this class of recursion is lost on me. 

Yes, Linux does have a nice chicken-and-egg process.  But unless you're
building a brand new arch, which means you have to fix glibc and gcc and
binutils to know about you, throwing in python isn't going to hurt you.
And if you're trying to do this on the machine you're trying to make
supported, you're going to have lots of fun.  In other words, I don't
see this as an issue.  If you're talking about bringing up a new board
for supported platform X, the only issue is getting Python2 onto the
system.  Which isn't nearly as painful as getting the kernel source, glibc
or gcc will be.  It'll only be maybe twice as painful as getting the bash
sources over (2.05) even. :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
