Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269206AbRHYONw>; Sat, 25 Aug 2001 10:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269238AbRHYONm>; Sat, 25 Aug 2001 10:13:42 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:45528 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S269206AbRHYONd>; Sat, 25 Aug 2001 10:13:33 -0400
Date: Sat, 25 Aug 2001 09:13:50 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] this patch add a possibility to add a random offset to
 the stack on exec.
In-Reply-To: <20010823104828.C1434@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.33.0108250856190.9625-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be much more productive to create some sort of stupid-code
detector so we can know where to fix things.  For example, hacking gcc to
offer warnings on any reference to 'auto' storage by I/O or ASCIZ string
functions, similar to that warning that ld throws when you use gets().

( I know that the nonexecutable stack patch has been shot down many times
as a security measure, but it *would* be a decent stupid-code detector
when combined with an exploit attempt.  Knowing that program X attempted
to aid and abet a burglar is better than expecting someone to comb through
every line of code on the 'net on the chance that holes will be found.
The burglars already do the latter, so why not put them to work detecting
bugs for us? :-} )

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Make a good day.

