Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRDYS4K>; Wed, 25 Apr 2001 14:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131244AbRDYS4A>; Wed, 25 Apr 2001 14:56:00 -0400
Received: from cr845378-a.rchrd1.on.wave.home.com ([24.157.76.7]:7719 "EHLO
	mielke.cc") by vger.kernel.org with ESMTP id <S131219AbRDYSzp>;
	Wed, 25 Apr 2001 14:55:45 -0400
Date: Wed, 25 Apr 2001 14:52:56 -0400 (EDT)
From: Dave Mielke <dave@mielke.cc>
To: Whit Blauvelt <whit@transpect.com>
cc: Tim Moore <timothymoore@bigfoot.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 Realaudio masq problem
In-Reply-To: <20010425133804.A1094@free.transpect.com>
Message-ID: <Pine.LNX.4.30.0104251450550.1012-100000@dave.private.mielke.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[quoted lines by Whit Blauvelt on April 25, 2001, at 13:38]

>On Tue, Apr 24, 2001 at 06:01:05PM -0700, Tim Moore wrote:
>> Try '# strace /usr/bin/X11/realplay On24ram.asp > log' and see where the
>> connect fails if you aren't getting specific error messages.
>
>Unfortunately this spits out a bunch of stuff and then totally freezes up my
>KDE 2.1.1 desktop.

strace writes to standard error, not standard output, by default. Better yet,
though, use the -o option of strace to direct its output to a file, which
leaves the standard output streams alone for the aplication being traced.

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.

