Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317018AbSFFRFe>; Thu, 6 Jun 2002 13:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317020AbSFFRFd>; Thu, 6 Jun 2002 13:05:33 -0400
Received: from murphys.services.quay.plus.net ([212.159.14.225]:388 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S317018AbSFFRFc>; Thu, 6 Jun 2002 13:05:32 -0400
Message-ID: <004d01c20d7c$1205a1e0$0501a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: "Greg Donald" <greg@destiney.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206061121020.23180-100000@destiney.com>
Subject: Re: list serv help
Date: Thu, 6 Jun 2002 18:02:49 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

yeah you dont have any mx records

[6 james@beast ~]$ host mail.destiney.com
Host mail.destiney.com. not found: 2(SERVFAIL)

[7 james@beast ~]$ host mail.destiney.com
Host mail.destiney.com. not found: 2(SERVFAIL)

[8 james@beast ~]$ host -tMX mail.destiney.com
Host mail.destiney.com. not found: 2(SERVFAIL)

[9 james@beast ~]$ host -tMX destiney.com
Host destiney.com. not found: 2(SERVFAIL)

[10 james@beast ~]$ host -tA destiney.com
destiney.com. has address 207.65.176.133



----- Original Message -----
From: "Greg Donald" <greg@destiney.com>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, June 06, 2002 5:42 PM
Subject: list serv help


>
> My server lost dns for several hours a couple of weeks back.  Since then
> I have made several unsuccessful attempts at getting back on the
> linux-kernel list serv.  As far as I can tell I was unsubscribed durign
> my dns outage.
>
> I started reading the available FAQs and came across the MX record
> verfication form at http://vger.kernel.org/mxverify.html:
>
> The results seem incorrect:
>
http://vger.kernel.org/cgi-bin/mxverify-cgi?DOMAIN=greg@destiney.com&SUBMIT=
Submit+to+VGER.KERNEL.ORG
>
> Testing MX server: mail.destiney.com
>
> --- sorry, address lookup for ``mail.destiney.com'' failed;
> code = Temporary failure in name resolution
>
>
> But when I try my domain from any other server I have no issues:
>
> firewall:~$ nslookup mail.destiney.com
> Server:  sun00bna.bna.bellsouth.net
> Address:  205.152.150.254
>
> Non-authoritative answer:
> Name:    destiney.com
> Address:  207.65.176.133
> Aliases:  mail.destiney.com
>
>
> +-(destiney@gateway)
> +-(~)> nslookup mail.destiney.com
> Server:         68.52.0.5
> Address:        68.52.0.5#53
>
> Non-authoritative answer:
> mail.destiney.com       canonical name = destiney.com.
> Name:   destiney.com
> Address: 207.65.176.133



