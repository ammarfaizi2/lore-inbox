Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269479AbUIZCGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269479AbUIZCGS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 22:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269481AbUIZCGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 22:06:18 -0400
Received: from holomorphy.com ([207.189.100.168]:52973 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269479AbUIZCGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 22:06:11 -0400
Date: Sat, 25 Sep 2004 19:05:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       rth@twiddle.net
Subject: Re: __attribute__((always_inline)) fiasco
Message-ID: <20040926020556.GR9106@holomorphy.com>
References: <1095956778.4966.940.camel@cube> <20040923165026.GF9106@holomorphy.com> <20040926012925.GA14305@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040926012925.GA14305@thundrix.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 12:26:18PM -0400, Albert Cahalan wrote:
>>> #define INLINE static inline  // an oxymoron
>>> #define INLINE extern inline  // an oxymoron

On Thu, Sep 23, 2004 at 09:50:26AM -0700, William Lee Irwin III wrote:
>> The // apart from being a C++ ism (screw C99; it's still non-idiomatic)
>> will cause spurious ignorance of the remainder of the line, which is
>> often very important. e.g.
>> static INLINE int lock_need_resched(spinlock_t *lock)
>> {
>> 	...

On Sun, Sep 26, 2004 at 03:29:25AM +0200, Tonnerre wrote:
> Mmm, shouldn't the comments be filtered *before* the definition is set
> in place? Just wondering...

I've already heard more about this than I ever cared to. I'll continue
to stick to saner subsets of C and refuse to use things such as how the
preprocessor committing incest with the compiler proper (no, I don't
need it explained to me, it's trivial) allows crappy code to be written.
Don't lecture me; there's nothing to explain and I don't want to hear it.

-- wli
