Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129243AbRBVBqq>; Wed, 21 Feb 2001 20:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130301AbRBVBqg>; Wed, 21 Feb 2001 20:46:36 -0500
Received: from palrel1.hp.com ([156.153.255.242]:40964 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S129243AbRBVBq1>;
	Wed, 21 Feb 2001 20:46:27 -0500
Message-ID: <3A946F71.69D94D13@cup.hp.com>
Date: Wed, 21 Feb 2001 17:46:25 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nye Liu <nyet@curtis.curtisfong.org>, linux-kernel@vger.kernel.org
Subject: Re: Very high bandwith packet based interface and performance problems
In-Reply-To: <E14VhQ7-0002s0-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > that because the kernel was getting 99% of the cpu, the application was
> > getting very little, and thus the read wasn't happening fast enough, and
> 
> Seems reasonable
> 
> > This is NOT what I'm seeing at all.. the kernel load appears to be
> > pegged at 100% (or very close to it), the user space app is getting
> > enough cpu time to read out about 10-20Mbit, and FURTHERMORE the kernel
> > appears to be ACKING ALL the traffic, which I don't understand at all
> > (e.g. the transmitter is simply blasting 300MBit of tcp unrestricted)
> 
> TCP _requires_ the remote end ack every 2nd frame regardless of progress.

um, I thought the spec says that ACK every 2nd segment is a SHOULD not a
MUST?

rick jones
-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
