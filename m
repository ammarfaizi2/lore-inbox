Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313925AbSEFAZq>; Sun, 5 May 2002 20:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313927AbSEFAZp>; Sun, 5 May 2002 20:25:45 -0400
Received: from relay1.pair.com ([209.68.1.20]:63494 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S313925AbSEFAZp>;
	Sun, 5 May 2002 20:25:45 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CD5CE35.3EF2B62E@kegel.com>
Date: Sun, 05 May 2002 17:28:37 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "khttpd-users@lists.alt.org" <khttpd-users@alt.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: khttpd rotten?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On vanilla 2.4.17, 2.4.18, and 2.4.19-pre8, I'm seeing 
some mighty strange khttpd behavior.
It's chewing CPU time, failing in mysterious ways under light
or no load, and oopsing easily.

I'm compiling a writeup at
http://www.kegel.com/linux/khttpd/
and it just keeps getting worse.  It looks like you have
to 1) turn on sloppymime, 2) never restart it, and 3) run
with only 1 thread to have any hope of stability -- and
even then, abruptly terminating client connections causes
an oops fairly frequently.

If I didn't need it for a demo this week (don't ask), I
wouldn't be messing with khttpd; I'd be switching to Tux.

Seems like it's time to either fix khttpd or pull it from the kernel.

What was the last kernel version where khttpd was stable (if any)?

- Dan
