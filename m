Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280646AbRK1URa>; Wed, 28 Nov 2001 15:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280627AbRK1URU>; Wed, 28 Nov 2001 15:17:20 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:31749 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280591AbRK1URF>; Wed, 28 Nov 2001 15:17:05 -0500
Date: Wed, 28 Nov 2001 16:59:47 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jeremy Puhlman <jpuhlman@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Google Test and 2.4.16
In-Reply-To: <3C0542F3.5A9F0EAA@mvista.com>
Message-ID: <Pine.LNX.4.21.0111281659180.15571-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Nov 2001, Jeremy Puhlman wrote:

> Ok yesterday got the google tests running...The machine I ran it on
> was a standard (Old) white box...Athlon k6-450 with 128 MB of
> Ram....Using 256 MB of swap....The google test tries to use an
> adjustable 1/2 terra byte Block size...This is unrealistic for an
> embedded system or my system for that matter..So in trying to tune the
> test to the system it seems they would not run unless the block size
> was less then 60 MB...Not sure what the deal was...I tried turning on
> memory-overcommit but no dice...
> 
> So basically I ran the test once through and every thing went fine...The
> 
> test didn't seem to really stress the system very much...
> 
> So I ran the same program 4 times, concurrently...The system did not
> seem to lose any responsiveness....This did stress the vm system since
> each of the processes were grabbing 60 megs...
> 
> I did find that once the 4 processes finished their runs. I ran one
> more just for fun...Then the system locked up...

Can you get the backtraces (with magic sysrq) of such a lockup ? 

