Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315293AbSFOMD6>; Sat, 15 Jun 2002 08:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315300AbSFOMD5>; Sat, 15 Jun 2002 08:03:57 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:11723 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315293AbSFOMD5>; Sat, 15 Jun 2002 08:03:57 -0400
Date: Sat, 15 Jun 2002 08:05:11 -0400
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020615120511.GA30803@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Recently, 2.5.20-dj[34] completed all my tests, whereas
>> 2.5.{19,20,21} haven't.   I realize breakage in the development series
>> is expected and sometimes good.  Nonetheless, "two thumbs up" for -dj.

> That's interesting. What exactly was failing ? It'd be in everyones
> interests to get those bits pushed to Linus sooner.

tiobench.pl --size 2048 --numruns 3 --threads 128  # 384 MB ram in machine

The ssh session running vmstat no longer updates.  Console won't
give a new "login" prompt with <Enter>.  <sysrq T> prints a 
trace (which I haven't captured - it's really long with > 128 processes).

Does <sysrq T> need any post processing to convert addresses to
something more useful?  I'll save it on 2.5.22 if it happens.

-- 
Randy Hron

