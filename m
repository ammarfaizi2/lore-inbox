Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSLZJh2>; Thu, 26 Dec 2002 04:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbSLZJh2>; Thu, 26 Dec 2002 04:37:28 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:3521 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S262824AbSLZJh1>; Thu, 26 Dec 2002 04:37:27 -0500
Message-ID: <20021226094537.20498.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: akpm@digeo.com, ciarrocchi@linuxmail.org
Cc: vda@port.imtp.ilyichevsk.odessa.ua, conman@kolivas.net,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
Date: Thu, 26 Dec 2002 17:45:37 +0800
Subject: Re: Poor performance with 2.5.52, load and process in D state
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@digeo.com>

> Paolo Ciarrocchi wrote:
> > 
> > > it appears that this benefit came from the special usercopy code.
> > > What sort of CPU are you using?
> > 
> > It is a PIII@800.
> 
> hm, don't know.  I built the latest postgres locally.  Perhaps the
> alignment of some application buffer is different.

I don't know. 
I've built the osdb test while I've just installed postgres
from the Mandrake 9 standard installation (so i586.rpm).

May be we are using different version of postgres...

Anyway, my test show that there is a lack of performance 
in 2.5.* is the kernel fits in a machine with low memory,
any hint ?

And probably the "standard" swappiness value is not the 
optimal, I'd like to see a few tests with the contest
tool ;-)


      Ciao,
               Paolo
-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
