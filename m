Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130884AbRAZJKI>; Fri, 26 Jan 2001 04:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129390AbRAZJJ6>; Fri, 26 Jan 2001 04:09:58 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:42501 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S129305AbRAZJJo>;
	Fri, 26 Jan 2001 04:09:44 -0500
Message-ID: <3A713E8F.131C6589@megapathdsl.net>
Date: Fri, 26 Jan 2001 01:08:31 -0800
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.1-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, chmouel@mandrakesoft.com
Subject: Re: Running "make install" runs lilo on my Athlon but not my Pentium II.
In-Reply-To: <200101222202.f0MM24s01811@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Miles Lane writes:
> > When I run "make install" on my Pentium II machine, lilo gets
> > run after vmlinuz is built.  When I do the same thing on my Athlon,
> > vmlinuz gets built, but lilo does get run.
> 
> Have you checked for the existance of a /sbin/installkernel file on either
> machine?

Yes.  The script exists on both machines, but I think you have
nailed the problem.  The working machine is running RedHat 6.2 plus
a 2.4.0+ kernel.  The other (the Athlon) is running Mandrake 7.2 plus
a 2.4.0+ kernel.  On the working machine, the installkernel script
is just a shell script.  While, on the problem machine, the script
is a PERL script written by chmouel@mandrakesoft.com.  

So, Chmouel, what gives?  Can you help me debug this?

Thanks Russell,

	Miles
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
