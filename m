Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279966AbRJ3Oxo>; Tue, 30 Oct 2001 09:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279961AbRJ3OxZ>; Tue, 30 Oct 2001 09:53:25 -0500
Received: from gaston.ina.fr ([194.3.210.66]:34542 "HELO gaston.ina.fr")
	by vger.kernel.org with SMTP id <S279966AbRJ3OxR>;
	Tue, 30 Oct 2001 09:53:17 -0500
Message-ID: <003e01c16152$ba69e840$222502c2@ina.fr>
From: "Matthieu Fleurmont" <mfleurmont@ina.fr>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0110300454530.1329-100000@dlang.diginsite.com>
Subject: debugging tools under 2.2.18 with RTL 3.0 pre10 patch
Date: Tue, 30 Oct 2001 15:54:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are developping a few kernel modules handling serial ports in order to have a
real time control on professional video systems as VTR, video servers and more
...

I am looking for a way that would allow me to have a kind of core dump instead
of of freezing and rebooting my box when my code is wrong and the module not
working properly...

Thanks to any one who already solved this problem and would share its experience
with me.

Best regards

Matthieu

----- Original Message -----
From: "David Lang" <david.lang@digitalinsight.com>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, October 30, 2001 2:04 PM
Subject: ipchains redirect failing in 2.4.5


> I am attempting to track down a problem I have run into with 2.4.5
>
> I have a firewall that has proxies listening on ports 1433-1437. If I
> connect to these proxies on these ports I have no problems, however if I
> put in an ipchains rule to redirect port 1433 on a second IP address to
> port 1436 (for example) and then hammer the box with ab -n 500 -s 20 the
> first 20 or so connections get through and then the rest timeout. doing
> repeated netstat -an on the firewall during this process shows an inital
> burst of 15 connections that get established, a pause, and then a handfull
> more get established, followed by those 20 connections being in TIME_WAIT
>
> again, connection to the same IP address on the real port the proxy is
> listening on has no problems, it's only when going through the redirect
> that it fails.
>
> any suggestions, tuning paramaters I missed, or tests I need to run to
> track this down?
>
> David Lang
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

