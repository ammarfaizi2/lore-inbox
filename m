Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266841AbTADKhK>; Sat, 4 Jan 2003 05:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266837AbTADKhK>; Sat, 4 Jan 2003 05:37:10 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:19106 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266840AbTADKhJ>; Sat, 4 Jan 2003 05:37:09 -0500
Subject: Re: odd phenomenon.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030103103816.GA2567@codemonkey.org.uk>
References: <20030103103816.GA2567@codemonkey.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1041677313.642.2.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 04 Jan 2003 11:48:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-03 at 11:38, Dave Jones wrote:
> Something strange I've noticed on all recent 2.4 and 2.5 kernels.
> 
> If I start galeon whilst I've got a bk pull in operation, the
> galeon process starts, opens its window, and then dies instantly.
> Starting it a second time works.
> 
> Its not OOM, as theres plenty of free RAM, and half gig of free (unused) swap.
> 
> It's almost 100% reproducable here.  Only seen it do it on this box
> though which is a P4 with HT, so it could be SMP related..

Happens all the time here too (ppc32), and did so for ages, with 2.4
(didn't specifically notice it with 2.5 yet, but I rarely use galeon
when testing 2.5 ;)

Typically happens with any kind of intense disk activity slowing down
galeon's launch process. (Not only bk, but also for example updatedb
running in the background).

I'm currently running galeon 1.2.6 (happened with all earlier versions
at least).

Ben.




