Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267055AbRGNAoQ>; Fri, 13 Jul 2001 20:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267483AbRGNAoH>; Fri, 13 Jul 2001 20:44:07 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2568 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267055AbRGNAnz>; Fri, 13 Jul 2001 20:43:55 -0400
Date: Fri, 13 Jul 2001 20:12:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] VM statistics code
In-Reply-To: <20010714123141.A6119@weta.f00f.org>
Message-ID: <Pine.LNX.4.21.0107132006540.3892-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Jul 2001, Chris Wedgwood wrote:

> On Fri, Jul 13, 2001 at 07:53:12PM -0300, Marcelo Tosatti wrote:
> 
>     Maybe. Personally I don't really care about the way we are doing
>     this, as long as I can get the information. I can add /proc/vmstat
>     easily if needed...
> 
> How about something under advance kernel hacking options of wherever
> the sysrq options is? (and profiling used to live, before it was
> always there), or, since the code is rather small, we could perhaps
> always have this available.

Well, it is already under "kernel hacking". 

I guess you missed it, right ? 

+VM statistics support
+CONFIG_VM_STATS
+  If you say Y here, the kernel will collect detailed information about 
+  the VM subsystem. This information will be available in /proc/stats. 
+  More documentation about this option can be found in 
+  Documentation/vm/statistics.
+  This is only useful for kernel hacking. If unsure, say N. 
+

Obviously we want this disabled by default.

>     Well, I don't want to include this stuff on the stock vmstat code
>     right now. I've done an ugly hack in vmstat.c to get the thing to
>     work and thats it.
> 
> Fair enough, but the comment "please apply" makes me nervous then :)

As I said, I'll keep an uptodated version of vmstat.c in my homepage for
the people who want to use it. Right now I don't the time to make a new
nice tool.


