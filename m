Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264712AbSKIMfe>; Sat, 9 Nov 2002 07:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264714AbSKIMfe>; Sat, 9 Nov 2002 07:35:34 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:48542 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264712AbSKIMfe>; Sat, 9 Nov 2002 07:35:34 -0500
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zwane@holomorphy.com, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <200211091200.NAA19909@harpo.it.uu.se>
References: <200211091200.NAA19909@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Nov 2002 13:05:49 +0000
Message-Id: <1036847149.20313.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-09 at 12:00, Mikael Pettersson wrote:
> If we configure for "I have a TSC, period" you add the option
> to disable it, which nullifies any benefit of the config option
> in the first place since we can't assume TSC presence any more.
> If we don't configure for TSC, you force tsc_disable, which means
> that a generic kernel _can't_ use the TSC.

2.4 was modified to printk a message that TSC was not disabled. This
does confuse people

