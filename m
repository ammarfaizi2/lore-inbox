Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264122AbRF0QmI>; Wed, 27 Jun 2001 12:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264169AbRF0Ql6>; Wed, 27 Jun 2001 12:41:58 -0400
Received: from eax.student.umd.edu ([129.2.236.2]:47622 "EHLO
	eax.student.umd.edu") by vger.kernel.org with ESMTP
	id <S264122AbRF0Qlw>; Wed, 27 Jun 2001 12:41:52 -0400
Date: Wed, 27 Jun 2001 11:39:27 -0500 (EST)
From: Adam <adam@eax.com>
X-X-Sender: <adam@eax.student.umd.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.x series and mm
In-Reply-To: <E15FI9n-0005Qz-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106271134440.16671-100000@eax.student.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.2.19+ do make slightly better decisions on the VM front, but at the end of
> the day swapping only works usefully when the working set still fits in
> RAM (ie all the stuff you keep needing).

> a)	Add more RAM - that is the real optimal approach
> b)	Make the processes smaller (eg switch to thttpd from www.acme.com)
> c)	Speed up the I/O throughput relative to CPU speed
> 	- eg the 2.2 IDE UDMA patches

can you elaborate on the "c" point" perhaps I could try it together with
2.2.20pre6 until I can do a).

about b) would it really help? AFACT the issue here is the buffers in
memory gets filled and cause other stuff to get swapped out., and that
would happen no matter what kind of web server I use..

-- 
Adam
http://www.eax.com      The Supreme Headquarters of the 32 bit registers


