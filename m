Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSGMUeh>; Sat, 13 Jul 2002 16:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSGMUeg>; Sat, 13 Jul 2002 16:34:36 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:20985 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315431AbSGMUeg>; Sat, 13 Jul 2002 16:34:36 -0400
Date: Sat, 13 Jul 2002 16:36:22 -0400
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: oprofile results with lmbench
Message-ID: <20020713203622.GA24297@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the numbers don't look right.  

> Perhaps you fed oprofpp the wrong vmlinux?

Thanks!  You are right. I just put a bold message
on the page that the results are invalid.  I'm leaving
the page up in case anyone else recommends changes.
I'll re-run the tests.

> btw, when using RETIRED_INSNS (or CPU_CLK_UNHALTED), you should
> boot the kernel with `idle=poll'.  Otherwise, idle time is
> unaccounted for in the profile and it gets really hard to interpret,
> and hard to compare runs.

I've added "idle=poll" to my lilo.conf append.

-- 
Rands Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

