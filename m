Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267321AbTAGGn7>; Tue, 7 Jan 2003 01:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTAGGn6>; Tue, 7 Jan 2003 01:43:58 -0500
Received: from [65.186.235.69] ([65.186.235.69]:11209 "EHLO bach.dynet.com")
	by vger.kernel.org with ESMTP id <S267321AbTAGGny>;
	Tue, 7 Jan 2003 01:43:54 -0500
Date: Tue, 7 Jan 2003 00:52:29 -0600
From: Charlton Harrison <charlton@dynet.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.19 & 2.4.20 hang without oops...
Message-ID: <20030107005229.A28504@bach.dynet.com>
Reply-To: charlton@dynet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone,


I'd like to report a (probable) kernel bug in v2.4.19 and v2.4.20.
This problem does NOT appear in 2.4.18 and I've had to go back to
that kernel for now.

The problem is as follows:
While attempting to copy about 50GB of data onto an NFS-mounted partition,
the `cp -a` process will go for a while, then my machine will hang/freeze up.

I can reproduce it very easily and quickly on kernel 2.4.19 and 2.4.20,
and most of the time happens before even copying 10GB worth of data.
I am unable to reproduce the problem on kernel 2.4.18.

Here are the specifics:

HARDWARE:

Dual (SMP) P3-500,  supermicro MB,  512MB ECC buffered SDRAM.
3c905b ethernet card.
EIDE hard drive operating on a 16MHz (UDMA *disabled*) bus.


SOFTWARE:

Compiled the kernel with Redhat GCC v2.96.
(I also compiled v2.4.18 the same way and it works)


I am very concerned about this bug and that it doesn't seem to be fixed
in the latest Linux 2.4 kernels.

For additional information,  please feel free to e-mail me.  Or, if you
happen to know something about this bug already,  please e-mail me.

Thanks!


Charlton Harrison
charlton@dynet.com
