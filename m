Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVIDWmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVIDWmz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 18:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVIDWmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 18:42:55 -0400
Received: from ms-smtp-01-lbl.southeast.rr.com ([24.25.9.100]:36493 "EHLO
	ms-smtp-01-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S932098AbVIDWmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 18:42:55 -0400
Message-Id: <200509042242.j84MgYWg019419@ms-smtp-01-eri0.southeast.rr.com>
From: "Matt LaPlante" <laplam@rpi.edu>
To: "'Jesper Juhl'" <jesper.juhl@gmail.com>
Cc: "'Herbert Xu'" <herbert@gondor.apana.org.au>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Potential IPSec DoS/Kernel Panic with 2.6.13
Date: Sun, 4 Sep 2005 18:42:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <9a87484905090411492cc3f823@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcWxgXYWeTh15vkASguJ6xCTze+FkgAH9ahQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Jesper Juhl
> Sent: Sunday, September 04, 2005 2:49 PM
> To: Matt LaPlante
> Cc: Herbert Xu; linux-kernel@vger.kernel.org
> Subject: Re: Potential IPSec DoS/Kernel Panic with 2.6.13
> 
> >
> serial console over a cross-over cable to a second box.
> netconsole will let you put the console on a different box over the
> network.
> console on line printer will let you have a permanent record of the
> console output on paper.
> 
> See
>  Documentation/serial-console.txt
>  Documentation/networking/netconsole.txt
>  the help entry for "config LP_CONSOLE" (in drivers/char/Kconfig)
> 

Well I've tried for several hours now to get netconsole working, but it just
won't give me output.  I've tried using both built in as well as module, and
I've tried two different clients using both netcat and syslogd on different
ports.  The most output I ever get is when loading the module I manage to
receive one message saying "netconsole: network logging started".  I've
verified all the netconsole settings are correct in the kernel logs when it
loads.  I'm not one to give up easily, but this one's got me stumped.

I know the option to use a printer is out...I might be able to manage a
serial connection, but I'll have to rebuild my kernel to support it.  I'll
look into that later...

-
Matt


