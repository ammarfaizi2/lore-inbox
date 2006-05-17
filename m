Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWEQOxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWEQOxh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 10:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWEQOxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 10:53:37 -0400
Received: from web26611.mail.ukl.yahoo.com ([217.146.177.63]:43355 "HELO
	web26611.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750771AbWEQOxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 10:53:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=IKMPnHdaPOaXXjw8fVcWVi+qSoW+zwG12UUp7rD0nED3q3v5gxMw+tDjeKB2z+QqtLIdXGyVJl9p1zfTJp8aC+1Fx7HoADWEFziK72mOAlGlfOBQ9aNDmuygvBe+vO0EjLYnURqHkHnVfmxEWIrd2Np8jgHTmWWItZK8s1sa+sM=  ;
Message-ID: <20060517145335.36079.qmail@web26611.mail.ukl.yahoo.com>
Date: Wed, 17 May 2006 16:53:35 +0200 (CEST)
From: linux cbon <linuxcbon@yahoo.fr>
Subject: Re: replacing X Window System !
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490605170639n12fde7c9i836599f02a30fd51@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Jesper Juhl <jesper.juhl@gmail.com> a écrit : 
> And when the windowing system crashes it'll take the
> kernel down with it - ouch.

It is already happening today with X, because :
X runs as root - ouch.
X can write into kernel memory - ouch.
X can mess with clocks - ouch.
X can mess with PCI bus - ouch.
etc.  - ouch.


> And if I want to run a headless server without a
> graphical display I
> can't simply stop the windowing system I'd have to
> rebuild a kernel
> without the windowing system in it - yuck.

Is it so difficult to disable a module ? - yuck.


> What we have now is a nicely decoupled system - it
> would be even
> better if X was even more decoupled from the kernel,
> but lets not put
> the windowing system in kernel space.

We dont need 2 kernels like today.
All "dangerous code" should be in kernel.


> Do you really want to put all that complexity into
> the kernel?

Kernel is already complex, that wouldnt affect it.
But that would greatly simplify the whole system.







	
	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger. Appelez le monde entier à partir de 0,012 €/minute ! 
Téléchargez sur http://fr.messenger.yahoo.com
