Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314654AbSD1AmP>; Sat, 27 Apr 2002 20:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314653AbSD1AmH>; Sat, 27 Apr 2002 20:42:07 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:52748 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314655AbSD1AmG>;
	Sat, 27 Apr 2002 20:42:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.5.10 problems 
In-Reply-To: Your message of "27 Apr 2002 11:32:46 MST."
             <1019932366.2001.8.camel@turbulence.megapathdsl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Apr 2002 10:41:55 +1000
Message-ID: <31547.1019954515@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Apr 2002 11:32:46 -0700, 
Miles Lane <miles@megapathdsl.net> wrote:
>My plan is to run "strace wombat", "strace evolution-mail" and
>"strace evolution-addressbook" in separate terminal windows.
>The evolution process can then be started normally.  

What state are the tasks in when it hangs, S, R, D, N, T, what?  I have
an intermittent problem on 2.4 where an entire process group goes into
T state even though nothing is tracing it.  Killing the offending
process then sending SIGCONT to the rest of the process group restarts
the group.  The offending process is usually the last one on the tree.

