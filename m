Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVBRLDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVBRLDC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 06:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVBRLDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 06:03:02 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:30010 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261326AbVBRLCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 06:02:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=JhXNXan9VxPfr27Y1OSL/FvI8bpB3wxmometaVhBiflUvp31Kc0y+BvsCJvV++yh7DriWN8Yxh4/PAU9c3d8OOImwOwGHg9LhFzHs8qX30ZEXppTMCGWKnRh3jozwca5kQLXn8sDL5Hj+f4JSRPDLknsbESnFsuoZfCL3kwSff0=
Date: Fri, 18 Feb 2005 11:58:04 +0100
From: Tomasz Zielonka <tomasz.zielonka@gmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Tupshin Harper <tupshin@tupshin.com>, darcs-users@darcs.net,
       lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Message-ID: <20050218105804.GA4901@students.mimuw.edu.pl>
References: <20050214020802.GA3047@bitmover.com> <200502172105.25677.pmcfarland@downeast.net> <421551F5.5090005@tupshin.com> <20050218090900.GA2071@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218090900.GA2071@opteron.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 10:09:00AM +0100, Andrea Arcangeli wrote:
> darcs scares me a bit because it's in haskell, I don't believe very much
> in functional languages for compute intensive stuff, ram utilization
> skyrockets sometime (I wouldn't like to need >1G of ram to manage the
> tree).

AFAICS, most of memory related problems in darcs are not necessarily a
result of using Haskell.

> Other languages like python or perl are much slower than C/C++ too but
> at least ram utilization can be normally dominated to sane levels with
> them and they can be greatly optimized easily with C/C++ extensions of
> the performance critical parts.

With those languages, you often have no other choice than resorting to
C. GHC is quite a good compiler and I've often been able to get my
programs run almost as fast as programs written in C++ - however, if I
were to write those programs in C++, I would never do that, despite
being quite a good C++ programmer.

Also, in Haskell you can use extensions written in C, as easily or even
easier than in Python or Perl (I've done this in Perl, heard the battle
stories about C extensions in Python). Haskell's FFI is quite good,
there are also many supporting tools.

Best regards
Tomasz

-- 
Szukamy programisty C++ i Haskell'a: http://tinyurl.com/5mw4e
