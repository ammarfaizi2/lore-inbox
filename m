Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290460AbSAXXan>; Thu, 24 Jan 2002 18:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290461AbSAXXad>; Thu, 24 Jan 2002 18:30:33 -0500
Received: from AMontpellier-201-1-1-52.abo.wanadoo.fr ([193.252.31.52]:27910
	"EHLO awak") by vger.kernel.org with ESMTP id <S290460AbSAXXaO> convert rfc822-to-8bit;
	Thu, 24 Jan 2002 18:30:14 -0500
Subject: Re: RFC: booleans and the kernel
From: Xavier Bestel <xavier.bestel@free.fr>
To: timothy.covell@ashavan.org
Cc: Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200201242308.g0ON8HL06970@home.ashavan.org.>
In-Reply-To: <Pine.LNX.4.44.0201241433110.2839-100000@waste.org>
	<200201242246.g0OMkML06890@home.ashavan.org.>
	<1011913193.810.26.camel@phantasy> 
	<200201242308.g0ON8HL06970@home.ashavan.org.>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 25 Jan 2002 00:27:45 +0100
Message-Id: <1011914865.2636.16.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le sam 26-01-2002 à 00:09, Timothy Covell a écrit :
> #include <stdio.h>
> 
> int main()
> {
>         char x;
> 
>         if ( x )
>         {
>                 printf ("\n We got here\n");
>         }
>         else
>         {
>                 // We never get here
>                 printf ("\n We never got here\n");
>         }
>         exit (0);
> }
> covell@xxxxxx ~>gcc -Wall foo.c
> foo.c: In function `main':
> foo.c:17: warning: implicit declaration of function `exit'

I'm lost. What do you want to prove ? (Al Viro would say you just want
to show you don't know C ;)
And why do you think you never get there ?

	Xav

