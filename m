Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280736AbRKGBfp>; Tue, 6 Nov 2001 20:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280731AbRKGBff>; Tue, 6 Nov 2001 20:35:35 -0500
Received: from netsrvr.ami.com.au ([203.55.31.38]:31762 "EHLO
	netsrvr.ami.com.au") by vger.kernel.org with ESMTP
	id <S280644AbRKGBf1>; Tue, 6 Nov 2001 20:35:27 -0500
Message-Id: <200111070133.fA71XPh11123@numbat.os2.ami.com.au>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: root <g.anzolin@inwind.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: Olivetti hangs in PCI initialisation 
In-Reply-To: Your message of "Tue, 06 Nov 2001 20:48:26 +0100."
             <20011106204826.A15663@fourier.home.intranet> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Nov 2001 09:33:25 +0800
From: John Summerfield <summer@os2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> --9amGYk9869ThD9tj
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> Hello,
> 
> I've just read your messages on linux-kernel about your problems with an
> Olivetti PC. I had similar problems with my PC (which is an Olivetti
> Modulo): it hanged on boot and the screen got black (this part is different).
>  
> Then it died.
> 
> I've found that my problem was caused by some lines in setup.S. Given
> that your problem has the same cause I'm attaching a patch which worked
> for me.
>

It was worth a try, but it had no effect that I could see.

>From other efforts it seems the problem may actually be connected with scrolling and it happens to be in the PCI detection code at the time the need arises.


-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my disposition.



