Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268934AbTBWViN>; Sun, 23 Feb 2003 16:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268954AbTBWViN>; Sun, 23 Feb 2003 16:38:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22537 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268934AbTBWViM>; Sun, 23 Feb 2003 16:38:12 -0500
Date: Sun, 23 Feb 2003 13:45:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <200302232115.h1NLF9wo000201@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0302231343050.1534-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Feb 2003, John Bradford wrote:
> 
> I could be wrong, but I always thought that Sparc, and a lot of other
> architectures could mark arbitrary areas of memory, (such as the
> stack), as non-executable, whereas x86 only lets you have one
> non-executable segment.

The x86 has that stupid "executablility is tied to a segment" thing, which
means that you cannot make things executable on a page-per-page level.  
It's a mistake, but it's one that _could_ be fixed in the architecture if
it really mattered, the same way the WP bit got fixed in the i486.

I'm definitely not saying that the x86 is perfect. It clearly isn't. But a 
lot of people complain about the wrong things, and a lot of people who 
tried to "fix" things just made them worse by throwing out the good parts 
too.

		Linus

