Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319461AbSILHUv>; Thu, 12 Sep 2002 03:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319469AbSILHUu>; Thu, 12 Sep 2002 03:20:50 -0400
Received: from denise.shiny.it ([194.20.232.1]:20450 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S319461AbSILHUu>;
	Thu, 12 Sep 2002 03:20:50 -0400
Message-ID: <XFMail.20020912092526.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <OFA28F240F.93209971-ON88256C31.005E5F03@boulder.ibm.com>
Date: Thu, 12 Sep 2002 09:25:26 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Jim Sibley <jlsibley@us.ibm.com>
Subject: RE: Killing/balancing processes when overcommited
Cc: Troy Reed <tdreed@us.ibm.com>, ltc@linux.ibm.com, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11-Sep-2002 Jim Sibley wrote:
> I have run into a situation in a multi-user Linux environment that when
> memory is exhausted, random things happen. [...] In a "well tuned" system,
> we are safe, but when the system accidentally (or deliberately) becomes
> "detuned", oom_kill is entered and arbitrarily kills  a  process.

It's not difficult to make the kerner choose the right processes
to kill. It's impossible. Imagine that when it goes oom the system
stops and asks you what processes have to be killed. What do you
kill ? I think the only way to save the system it to tell the kernel
which are the processes that must not be killed, except in extreme
conditions. Probably we do need an oomd that the sysadmin can
configure as he likes.


Bye.

