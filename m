Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbSLJSYu>; Tue, 10 Dec 2002 13:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbSLJSYu>; Tue, 10 Dec 2002 13:24:50 -0500
Received: from texas.pobox.com ([64.49.223.111]:35478 "EHLO texas.pobox.com")
	by vger.kernel.org with ESMTP id <S265222AbSLJSYp>;
	Tue, 10 Dec 2002 13:24:45 -0500
Date: Wed, 11 Dec 2002 00:02:18 +0530
From: Joshua N Pritikin <vishnu@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: robm@flipturn.org
Subject: Re: longrun not working
Message-ID: <20021210183218.GB1521@always.joy.eth.net>
References: <20021208160349.GA712@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021208160349.GA712@always.joy.eth.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 09:33:49PM +0530, Joshua N Pritikin wrote:
> i have a Fujitsu P-Series laptop (TM5800 CPU @ 800MHz) running Linux
> 2.4.20 (debian) with devfs, CONFIG_MCRUSOE, CONFIG_X86_MSR, and
> CONFIG_X86_CPUID.
> 
> emit:/usr/src/pseries/longrun# ls -l /dev/cpu/0/
> total 0
> crw-rw----    1 root     root     203,   0 Dec  8  2002 cpuid
> crw-rw----    1 root     root     202,   0 Dec  8  2002 msr
> 
> When i try longrun 0.9, i get a failure at the first call to
> read_cpuid() in check_cpu(), line 186.
> 
> (Actually longrun was working on my laptop about a month ago
> then it mysterious started failing, as described.  i don't
> know what changed.)
> 
> Who is maintaining longrun?  What more information can i provide
> to help in debugging?

This problem was due to some problem in the debian unstable
version of libc6.  i am filing a bug report with debian.

-- 
Victory to the Divine Mother!!         after all,
  http://sahajayoga.org                  http://why-compete.org
