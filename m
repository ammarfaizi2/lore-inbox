Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280484AbRKJFRi>; Sat, 10 Nov 2001 00:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280480AbRKJFR3>; Sat, 10 Nov 2001 00:17:29 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:33288 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280484AbRKJFRX>; Sat, 10 Nov 2001 00:17:23 -0500
Message-ID: <3BECB84D.9D8341ED@zip.com.au>
Date: Fri, 09 Nov 2001 21:17:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Walter <srwalter@yahoo.com>
CC: linux-kernel@vger.kernel.org, andrea@e-mind.com
Subject: Re: Insanely high "Cached" value
In-Reply-To: <20011109230439.A13013@hapablap.dyn.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Walter wrote:
> 
> My system has been running a little over twelve days now, and I just
> noticed that the "Cached" value in both 'free' and /proc/meminfo is
> insanely high.  This wasn't the case the last time I checked, which was
> probably a day ago.
> 
> Just before checking it this time, I ran a "du -s *" in /usr, which
> generated a lot of I/O, as it to be expected.  Perhaps the large amount
> of I/O has uncovered a bug of some sort?
> 
> This is kernel 2.4.13 (hopefully it's not something that's already been
> reported and fixed; I haven't seen it if is has) patched with ext3, kdb,
> lm_sensors, and the pre-empt patch.  Seems likely to be only a simple VM
> problem, however, and an asthetic one at that.

It's an ext3 bug.  Harmless, fixed in the (ext3-enriched) 2.4.15-pre2.

-
