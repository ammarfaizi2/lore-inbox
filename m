Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130243AbQKIFAg>; Thu, 9 Nov 2000 00:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130217AbQKIFA2>; Thu, 9 Nov 2000 00:00:28 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:28406 "HELO
	halfway.linuxcare.com.au") by vger.kernel.org with SMTP
	id <S129766AbQKIFAN>; Thu, 9 Nov 2000 00:00:13 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Michael Kummer <frost@f00bar.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: need urgent help with 2.2.17 + ipchains 
In-Reply-To: Your message of "Tue, 07 Nov 2000 22:43:06 BST."
             <Pine.LNX.4.30.0011072239150.31349-100000@warp4.lan-rockerz.net> 
Date: Thu, 09 Nov 2000 16:00:09 +1100
Message-Id: <20001109050009.17F4A8120@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.30.0011072239150.31349-100000@warp4.lan-rockerz.net> you
 write:
> hi!
> 
> i have the following very nasty problem.
> everytime i execute ipchains -F [rule] my box freezes for 25 minutes!
> i run slackware on 2.2.17.

You mean `ipchains -F [chain]'?  It's possible that your rules could
be ordered so that this command breaks when executed remotely.  Are
you running this locally?

Rusty.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
