Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281683AbRKQCVp>; Fri, 16 Nov 2001 21:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281685AbRKQCVf>; Fri, 16 Nov 2001 21:21:35 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:59778 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281683AbRKQCVT>; Fri, 16 Nov 2001 21:21:19 -0500
Message-ID: <002e01c16f0e$6a2290c0$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "David Flynn" <Dave@keston.u-net.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <002501c16e0c$d3800550$f5976dcf@nwfs> <016a01c16e14$3a937c70$1901a8c0@node0.idium.eu.org>
Subject: Re: Microsoft IE6 is crashing with Linux 2.4.X
Date: Fri, 16 Nov 2001 19:20:23 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

We got to the bottom of the problem.  IE6 is just plain busted and infested
with bugs.

Jeff

----- Original Message -----
From: "David Flynn" <Dave@keston.u-net.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>;
<linux-kernel@vger.kernel.org>
Sent: Thursday, November 15, 2001 1:29 PM
Subject: Re: Microsoft IE6 is crashing with Linux 2.4.X


> > The connection to the server has failed. Account: 'mail.timpanogas.org',
> > Server: 'mail.timpanogas.org', Protocol: SMTP, Port: 25, Secure(SSL):
No,
> > Socket Error: 10061, Error Number: 0x800CCC0E
>
> This error is WSACONNREFUSED, (ie connection refused), this is generated
by
> the target machine.  Check to see if you can 'telnet' the into the box,
>
> telnet mail.timpanogas.org 25
>
> see if it connects and gives the '220 identification line' it will look
> something like this:
> 220 firewall0.node0.idium.eu.org ESMTP Exim 3.31 #1 Thu, 15 Nov 2001
> 20:25:00 +0000
>
> Regards,
>
> Dave

