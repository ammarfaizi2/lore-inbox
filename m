Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273087AbRIIWtu>; Sun, 9 Sep 2001 18:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273089AbRIIWtj>; Sun, 9 Sep 2001 18:49:39 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:57068 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S273087AbRIIWt1>; Sun, 9 Sep 2001 18:49:27 -0400
Message-ID: <066701c13981$b9e91830$1125a8c0@wednesday>
From: "J. Dow" <jdow@earthlink.net>
To: <tegeran@home.com>, "Carsten Leonhardt" <leo@debian.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <87g09w70o4.fsf@cymoril.oche.de> <01090915115400.00173@c779218-a> <063301c1397e$0efa6d00$1125a8c0@wednesday> <01090915292502.00173@c779218-a>
Subject: Re: Athlon/K7-Opimisation problems
Date: Sun, 9 Sep 2001 15:49:46 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Nicholas Knight" <tegeran@home.com>

> > What about the power supply. If it is at all marginal the power
> > consumption boost going to 1.4G is likely a killer.
> 
> Well, he didn't mention the amperage outputs, but he said 431W Enermax, 
> from what I hear Enermax PSU's are good.
> I still have trouble dealing with the idea that the optimizations cause 
> power consumption like this, but then, I have trouble with my own idea 
> that it causes sufficient heat increase in the chipset that soon after 
> boot.
> 
> Do most people that experience this problem also experience after a 
> cold-boot where the system had been off for at least 10-15 minutes? And 
> has ANYONE sucsesfully cured this problem by changing power supplies?

Don't forget that there are two regulators involved. First there is the
primary power supply's regulator down to either 3.3 or 5 volts. Then there
is the motherboard regulator down to the 1.7 volt range. If THAT one is
not up to handling the required oompf during certain CPU loads that is a
sure way to glitch the machine.

{^_^}

