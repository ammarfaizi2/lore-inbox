Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318198AbSHSH3e>; Mon, 19 Aug 2002 03:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318200AbSHSH3e>; Mon, 19 Aug 2002 03:29:34 -0400
Received: from adsl-161-92.barak.net.il ([62.90.161.92]:31498 "EHLO
	hirame.qlusters.com") by vger.kernel.org with ESMTP
	id <S318198AbSHSH3d>; Mon, 19 Aug 2002 03:29:33 -0400
Subject: Re: *Challenge* Finding a solution (When kernel boots it does not
	display any system info)
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: louie miranda <louie@chikka.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <02bc01c24746$9d08d600$0300000a@nocpc2>
References: <20020818021522.GA21643@waste.org>
	<20020819054359.GB26519@think.thunk.org> 
	<02bc01c24746$9d08d600$0300000a@nocpc2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Aug 2002 10:30:30 +0300
Message-Id: <1029742232.31934.31.camel@sake>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 09:06, louie miranda wrote:
> Is there a patch or any configuration's, info*.
> When the kernel boots.. it just display only the Lilo, etc. a few lines
> after lilo.. and just pauses for a while and after a few seconds
> display the login prompt?

What you describe sounds exactly like what you would see if the console
output was redirected to somewhere else. For example, if you set LILO to
use (also) the serial port and add a serial console to inittab but not
redirect the console output to the serial port you will see exactly what
you describe on a terminal connected to the port.

Check what is set as the console and what parameters are passed to lilo.

Did I pass the challange? :-)

> 
> I've seen this once!, but i can't remember where..

A 'woke up screaming' nightmare about working for Linux Corp. inc. and
having the Marketing dept. file an ECO that you remove all those pesky
boot message because it scares the lusers? ;-)


Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
Code mangler, senior coffee drinker and VP SIGSEGV
Qlusters ltd.

"You got an EMP device in the server room? That is so cool."
      -- from a hackers-il thread on paranoia



