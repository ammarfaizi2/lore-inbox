Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbUJZOZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUJZOZM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUJZOZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:25:12 -0400
Received: from holomorphy.com ([207.189.100.168]:37604 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262273AbUJZOZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:25:06 -0400
Date: Tue, 26 Oct 2004 07:24:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Bill Davidsen <davidsen@tmr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041026142434.GG17038@holomorphy.com>
References: <200410260142_MC3-1-8D2A-45C2@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410260142_MC3-1-8D2A-45C2@compuserve.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 01:40:16AM -0400, Chuck Ebbert wrote:
>   Problem is, kernel.org 'release' kernels are quite buggy.  For
> example 2.6.9 has a long list of bugs:
>   - superio parports don't work
>   - TCP networking using TSO gives memory allocation failures
>   - s390 has a serious security bug (sacf)
>   - ppp hangup is broken with some peers
>   - exec leaks POSIX timer memory and loses signals
>   - auditing can deadlock
>   - O_DIRECT and mmap IO can't be used together
>   - procfs shows the wrong parent PID in some cases
>   - i8042 fails to initialize with some boards using legacy USB
>   - kswapd still goes into a frenzy now and then
>   Sure, the next release will (may?) fix these bugs, but it will definitely
> add a whole set of new ones.

And which of these are new in 2.6.9? The bug list shrinks in newer
releases.  The fact there are sometimes new ones is an unavoidable
fact of life. Trying to slow down development won't prevent it.


-- wli
