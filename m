Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTEWPYb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 11:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbTEWPYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 11:24:31 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:46852 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264083AbTEWPY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 11:24:29 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.21-rc3 - ipmi unresolved
Date: Fri, 23 May 2003 15:41:43 +0200
User-Agent: KMail/1.5.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva> <3ECE246D.E3B27BCB@eyal.emu.id.au>
In-Reply-To: <3ECE246D.E3B27BCB@eyal.emu.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305231541.43803.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 May 2003 15:38, Eyal Lebedinsky wrote:

Hi Eyal,

> The exports in ksyms are still necessary, and missing:
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-rc3/kernel/drivers/char/ipmi/ipmi_msghandler.o
> depmod:         panic_notifier_list
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-rc3/kernel/drivers/char/ipmi/ipmi_watchdog.o
> depmod:         panic_notifier_list
> depmod:         panic_timeout
> The attached snippet was part of the earlier, larger patch.
I've send this fix 3 times and I gave up after silent ignores ;)

ciao, Marc


