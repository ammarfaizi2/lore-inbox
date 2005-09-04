Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVIDWBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVIDWBS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 18:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVIDWBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 18:01:18 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60864 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932089AbVIDWBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 18:01:14 -0400
Message-Id: <200509042106.j84L6kvV019764@laptop11.inf.utfsm.cl>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Harald Welte <laforge@gnumonks.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver 
In-Reply-To: Message from Jesper Juhl <jesper.juhl@gmail.com> 
   of "Sun, 04 Sep 2005 00:27:20 +0200." <9a87484905090315273f9b7048@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 04 Sep 2005 17:06:46 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 9/4/05, Harald Welte <laforge@gnumonks.org> wrote:
> > On Sun, Sep 04, 2005 at 12:12:18PM +0200, Harald Welte wrote:
> > > Hi!
> > >
> > > Below you can find a driver for the Omnikey CardMan 4040 PCMCIA
> > > Smartcard Reader.
> > 
> > Sorry, the patch was missing a "cg-add" of the header file.  Please use
> > the patch below.
> 
> It would be so much nicer if the patch actually was "below" - that is
> "inline in the email as opposed to as an attachment". Having to first
> save an attachment and then cut'n'paste from it is a pain.
> 
> Anyway, a few comments below :

[...]

> +	unsigned long ulBytesToRead;
> 
> 
> lowercase prefered also for variables.

Also, "encoding" the type (ul) into the variable name is nonsense.

[...]

> +	ulMin = (count < (ulBytesToRead+5))?count:(ulBytesToRead+5);

Again.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
