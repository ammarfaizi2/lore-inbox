Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318040AbSGPVr2>; Tue, 16 Jul 2002 17:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318134AbSGPVr1>; Tue, 16 Jul 2002 17:47:27 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35570 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318040AbSGPVr1>; Tue, 16 Jul 2002 17:47:27 -0400
Subject: Re: [PATCH] aha152x fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Filip Van Raemdonck <filipvr@xs4all.be>
Cc: linux-kernel@vger.kernel.org, fischer@norbit.de,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20020716231003.A488@lucretia.debian.net>
References: <20020716231003.A488@lucretia.debian.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Jul 2002 00:00:30 +0100
Message-Id: <1026860430.1688.95.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-16 at 22:10, Filip Van Raemdonck wrote:
> Hi,
> 
> I upgraded from 2.4.19-pre7 to -rc1 and this resulted in my aha152x card not
> working anymore. (The error was "trying software interrupt, lost")
> 
> Below is a patch which makes it work again. Note that this is just reverting
> a minimal part of the last applied patch to aha152x.c; so this may only be
> fixing the symptom and not the problem.
> 
> Can somebody confirm if this is correct or not, and give some more insight
> into this behaviour?

I've seen reports but not figured out what is going on yet. Are you
using an AHA152x or the PCMCIA version ?

