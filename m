Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272338AbRILSW7>; Wed, 12 Sep 2001 14:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272429AbRILSWu>; Wed, 12 Sep 2001 14:22:50 -0400
Received: from anguita.dti2.net ([195.57.112.8]:55558 "EHLO anguita.dti2.net")
	by vger.kernel.org with ESMTP id <S272338AbRILSWc>;
	Wed, 12 Sep 2001 14:22:32 -0400
Message-ID: <24da01c13bb7$b6495e00$061010ac@dti2.net>
From: "Jorge Boncompte [DTI2]" <jorge@dti2.net>
To: "Jens Hoefkens" <hoefkens@msu.edu>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0108282340130.12708-100000@dvorak>
Subject: Re: 2.2.19 boot failure
Date: Wed, 12 Sep 2001 20:21:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-MDRemoteIP: 195.57.112.5
X-Return-Path: jorge@dti2.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Jens Hoefkens" <hoefkens@msu.edu>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, August 29, 2001 6:21 AM
Subject: Re: 2.2.19 boot failure


> On Mon, 27 Aug 2001, Alan Cox wrote:
>
> >
> > Can you boot it with a serial console ?
> >
>
> Hi Alan.
>
> I have the same problem with the serial console. The single CPU kernel
> boots fine and dumps the log to the serial port, the SMP kernel
> freezes right after
>
> "Uncompressing Linux... OK, booting the kernel"
>
> and there is no output to the serial console. However, I have done
> some more tests with 2.4.9 kernels.
>
> 1) Single CPU 2.4.9 boots and reports tons of machine check exceptions
> (output from the serial console in [1]). I also tried my best runnung
> the OOPS trhough ksymoops ([3]).
>
> 2) Single CPU 2.4.9 with "nomce" parameter boots fine ([2]).
>
> 3) SMP 2.4.9 freezes the machine right after "OK, booting the kernel"
> (with and without the "nomce" parameter).
>
> Btw, I have swapped the CPUs around with no change. Moreover, I
> remember that an earlier 2.2 kernel worked with both CPUs on this
> board (if necessary, I can go back and try to find the last working
> kernel - although it will take some time).
>


     Hello,

   I have recently upgraded a server, from 2.4.4 to 2.4.9, with a M54p-09N
motherboard (Dual Pentium 133) and I've got the same result, with two
differences, mine boots in SMP with "nomce", and I don't get any oops, the
server just hangs after all that MCE reports.

    Is there something that I could do to debug it?

    Regards.

    -Jorge

==============================================================
Jorge Boncompte - Técnico de sistemas
DTI2 - Desarrollo de la Tecnología de las Comunicaciones
--------------------------------------------------------------
C/ Abogado Enriquez Barrios, 5   14004 CORDOBA (SPAIN)
Tlf: +34 957 761395 / FAX: +34 957 450380
--------------------------------------------------------------
jorge@dti2.net _-_-_-_-_-_-_-_-_-_-_-_-_-_ http://www.dti2.net
==============================================================
- Sin pistachos no hay Rock & Roll...
- Without wicker a basket cannot be done.
==============================================================


