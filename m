Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279875AbRKIMv0>; Fri, 9 Nov 2001 07:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279878AbRKIMvQ>; Fri, 9 Nov 2001 07:51:16 -0500
Received: from ids.big.univali.br ([200.169.51.11]:20621 "HELO
	mail.big.univali.br") by vger.kernel.org with SMTP
	id <S279875AbRKIMvJ>; Fri, 9 Nov 2001 07:51:09 -0500
Message-Id: <5.1.0.14.1.20011109105000.00aa8948@mail.big.univali.br>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 09 Nov 2001 10:51:20 -0300
To: linux-kernel@vger.kernel.org
From: Marcus Grando <marcus@big.univali.br>
Subject: Re: BUG(?): kswapd eating CPU
Mime-Version: 1.0
Content-Type: multipart/mixed; x-avg-checked=avg-ok-67082FF; boundary="=======3F5834E8======="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=======3F5834E8=======
Content-Type: text/plain; x-avg-checked=avg-ok-67082FF; charset=us-ascii
Content-Transfer-Encoding: 8bit

	Hello all,

	I have this problems too.

	Any sugestions?

Regards
Marcus Grando

> I just had a strange case where kswapd started eating up 100% CPU
>time.  I haven't been able to reproduce it, but it seemed to occur when I
>did a "dd bs=4096 </dev/fb0 >/scratch/image" in X while writing a CD (4x)
>from the same filesystem--the dd took 10-20 times longer than usual, and
>kswapd's run time from ps also pointed to the same time.  At the time,
>roughly 6MB of real memory was free, but most in-use memory (~800MB) was
>cached data; only 3MB or so of swap was used.  The system itself seemed to
>remain stable, though I rebooted shortly after I discovered the problem.
>
>     System is as follows: (if more info is desired, please contact me
>directly at achurch@achurch.org--I'm not subscribed to the list)

--=======3F5834E8=======--

