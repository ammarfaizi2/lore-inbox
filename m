Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272201AbRHXPvJ>; Fri, 24 Aug 2001 11:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272189AbRHXPun>; Fri, 24 Aug 2001 11:50:43 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:17549
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S272190AbRHXPuk>; Fri, 24 Aug 2001 11:50:40 -0400
Date: Fri, 24 Aug 2001 08:50:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jes Sorensen <jes@sunsite.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010824085052.K14302@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E15a1rW-000MM9-00@f10.mail.ru> <20010823143443.F14302@cpe-24-221-152-185.az.sprintbbd.net> <d3ofp5wr46.fsf@lxplus035.cern.ch> <20010824083728.J14302@cpe-24-221-152-185.az.sprintbbd.net> <d31ym1wjk8.fsf@lxplus035.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31ym1wjk8.fsf@lxplus035.cern.ch>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 05:42:47PM +0200, Jes Sorensen wrote:
 
> The real problems with Perl is that it exercises almost all of your
> libc, uses floating point math, dlopen() and a lot of other
> funnies. Successfully running Perl's test suite is a very good
> indicator for the completeness of your libc. On the other hand gcc and
> the development toolchain are remarkably easy to accomodate on that
> front.

We're getting someplace now.  If you question the ability of the platform
to make reliable tools such as perl, why do you think you'll have good
binutils and gcc on the platform?  If your platform doesn't have dlopen()
working then yes, python2 will probably be pissed off.  I conceeded this
last time too I think.  If you're trying to bring up a platform
compiling a kernel is a good test of having lots of things working.  With
2.6 it'll mean one more thing is at least somewhat working, dlopen().  Or
you can go and make a CML2 interp in C.  Or sh.  I'm quite happy cross
compiling stuff until things get a bit farther along on a brand spanking new
platform.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
