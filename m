Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbTEZB4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 21:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263844AbTEZB4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 21:56:15 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:36350 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP id S263837AbTEZB4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 21:56:14 -0400
Message-ID: <3ED17753.5090009@acm.org>
Date: Sun, 25 May 2003 21:09:23 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
CC: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3 - ipmi unresolved
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva> <3ECE246D.E3B27BCB@eyal.emu.id.au> <200305231541.43803.m.c.p@wolk-project.de>
In-Reply-To: <200305231541.43803.m.c.p@wolk-project.de>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:

>On Friday 23 May 2003 15:38, Eyal Lebedinsky wrote:
>
>Hi Eyal,
>
>  
>
>>The exports in ksyms are still necessary, and missing:
>>depmod: *** Unresolved symbols in
>>/lib/modules/2.4.21-rc3/kernel/drivers/char/ipmi/ipmi_msghandler.o
>>depmod:         panic_notifier_list
>>depmod: *** Unresolved symbols in
>>/lib/modules/2.4.21-rc3/kernel/drivers/char/ipmi/ipmi_watchdog.o
>>depmod:         panic_notifier_list
>>depmod:         panic_timeout
>>The attached snippet was part of the earlier, larger patch.
>>    
>>
>I've send this fix 3 times and I gave up after silent ignores ;)
>
I've resent my fixes, Marcelo said earlier he would take them, but they
didn't get into this release.

-Corey

