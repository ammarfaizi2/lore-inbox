Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUJHUtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUJHUtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUJHUtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:49:03 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:38919 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265093AbUJHUqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:46:31 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] Make gcc -align options .config-settable
Date: Fri, 8 Oct 2004 23:46:24 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <2KBq9-2S1-15@gated-at.bofh.it> <200410081710.58766.vda@port.imtp.ilyichevsk.odessa.ua> <20041008154227.GA91816@muc.de>
In-Reply-To: <20041008154227.GA91816@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410082346.24150.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I would just do a single CONFIG_NO_ALIGNMENTS that sets everything to
> > > 1, that should be enough.
> > 
> > For me, yes, but there are people which are slightly less obsessed
> > with code size than me.
> > 
> > They might want to say "try to align to 16 bytes if
> > it costs less than 5 bytes" etc.
> 
> If they want to go down to that low level they can as well edit
> the Makefiles. But we already have far too many configs and
> adding new ones for obscure compiler options is not a good idea.
> 
> Also we don't normally add stuff "just in case", but only when
> people actually use it.

I have a suspicion that if I had submitted CONFIG_NO_ALIGNMENTS
patch instead, there would be comments from another crowd,
about it being too coarse.

Look at the post of Grzegorz Kulewski.

Anyway, I don't have strong preference. I just want to be at least
able to disable code alignment completely.
--
vda

