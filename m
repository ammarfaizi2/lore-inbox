Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264805AbRFUEIi>; Thu, 21 Jun 2001 00:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbRFUEI2>; Thu, 21 Jun 2001 00:08:28 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:49895 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S264805AbRFUEIW>; Thu, 21 Jun 2001 00:08:22 -0400
Message-ID: <3B3173A0.F244EF5B@kegel.com>
Date: Wed, 20 Jun 2001 21:10:08 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Threads, inelegance, and Java
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Leighton wrote:
> The lack of a good operating system _dependent_ interface
> makes running fast hard in Java when you need to do IO...
> yes, there is always JNI so you can add a little C to mmap a file or whatever,

JDK 1.4 beta comes with a way to memory-map files, and various
other I/O improvements (like poll(); see http://www.jcp.org/jsr/detail/51.jsp).
Chris Smith will have some nio benchmarks up on http://www.jlinux.org/
next week or so showing how well their nonblocking network I/O performs.

Sun is slowly getting their act together on the I/O front with java.
Still, the competition from C# and for that matter gcj will probably be 
a good thing, keep 'em on their toes.

(Disclaimer: I served on the JSR-51 expert group, representing the linux 
point of view, kinda.)
- Dan
