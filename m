Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282213AbRKWT76>; Fri, 23 Nov 2001 14:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282214AbRKWT7s>; Fri, 23 Nov 2001 14:59:48 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:9600 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S282213AbRKWT7j>; Fri, 23 Nov 2001 14:59:39 -0500
Message-ID: <017901c17459$5624acc0$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "lkml" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0111231627020.11090-100000@freak.distro.conectiva>
Subject: Re: IDE is still crap.. or something
Date: Fri, 23 Nov 2001 20:59:18 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
To: "Martin Eriksson" <nitrax@giron.wox.org>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Sent: Friday, November 23, 2001 7:27 PM
Subject: Re: IDE is still crap.. or something


>
> Any previous kernel gave you good performance ?

No.. not really. Except -ac kernels and kernels with the preempt patch.

I'll just clarify: The problem is not that hard disk operations gets slow (I
can understand *that*, as it's a MW-DMA2 disk and one UDMA33 running ext3),
instead the real problem is that the system as a *whole* gets painfully
slow. Whilst copying a 500MB file, it takes ~6-8 seconds to start a new ssh
session from my windows comp to my linux server, compared to <1 second when
running preempt/ac kernels.

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden

>
> On Fri, 23 Nov 2001, Martin Eriksson wrote:
>
> > Well, just wanted to tell you that 2.4.15 still slows down to a crawl
when
> > copying a 500MB file between two hard drives (running ext3). I have
tried
> > any of the -c -u -m -W settings in hdparm. I even applied the 2.4.14 IDE
> > patch (after fixing the rejects) but no go.
> >
> > Even iptables is affected, because it takes forever to surf the internet
> > from my behind-linux-firewall windows computer.
> >
> > I'm right now trying to apply the preemptive-kernel patch to 2.4.15 but
it
> > had some strange rejects so it will be exciting to see if it works. I
get
> > good response from the -ac kernel series though.


