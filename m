Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbSKPObP>; Sat, 16 Nov 2002 09:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbSKPObP>; Sat, 16 Nov 2002 09:31:15 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:20489 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265077AbSKPObO>; Sat, 16 Nov 2002 09:31:14 -0500
Date: Sat, 16 Nov 2002 12:37:54 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why can't Johnny compile?
Message-ID: <20021116143754.GH24641@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
References: <3DD5D93F.8070505@kegel.com> <3DD5D93F.8070505@kegel.com> <3DD5DC77.2010406@pobox.com> <8$ya-6IXw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8$ya-6IXw-B@khms.westfalen.de>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 16, 2002 at 11:47:00AM +0200, Kai Henningsen escreveu:
> jgarzik@pobox.com (Jeff Garzik)  wrote on 16.11.02 in <3DD5DC77.2010406@pobox.com>:
> 
> > Most of the stuff that doesn't compile (or link) is typically stuff that
> > is lesser used, or never used.  A lot of the don't-compile complaints
> > seem to be vocal-minority type complaints or "why can't I build _every_
> > module in the kernel?" complaints.  Ref allmodconfig, above.
> 
> So maybe there should be a list of config symbols to turn off (preferrably  
> automatically) after allmodconfig or so, a "we know this is broken" list.

Humm, I've been playing with this, if you're willing to add this feature to
kbuild, I'll be happy to provide such a list, even with short explanation
on why it is broken (dma, cli/sti, schedule_task, etc). In fact I'll probably
have it anyway and do a grep -vf...

- Arnaldo
