Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131500AbRAKHWu>; Thu, 11 Jan 2001 02:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131615AbRAKHWk>; Thu, 11 Jan 2001 02:22:40 -0500
Received: from [200.222.195.217] ([200.222.195.217]:47503 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S131500AbRAKHWY>; Thu, 11 Jan 2001 02:22:24 -0500
Date: Thu, 11 Jan 2001 05:22:10 -0200
From: Frédéric L . W . Meunier 
	<0@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 umount problem
Message-ID: <20010111052210.H1130@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
X-Mailer: Mutt/1.3.12i - Linux 2.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, when 2.2.0 was released (yes, 2.2), I moved from
2.0.36 to it on a RedHat 5.1 with all the updates and the rest
built from scratch. And shutting down the system gave me the
same results: / -> device or resource busy. No need to say
that fsck was used. The other partitions were cleanly
unmounted.

2.2.1 was released after some days. Rebooting with this Kernel
would do the same. Then (I was too lazy to try fuser or lsof) I
started doing init 1 and umount / for half a year, then it
worked again (I don't know what changed, but I never edited the
RedHat scripts).

BTW, what's the problem with devfs? I plan to use it, but now
am afraid.

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
