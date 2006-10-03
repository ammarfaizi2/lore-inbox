Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965256AbWJCFlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965256AbWJCFlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 01:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbWJCFlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 01:41:36 -0400
Received: from outmx019.isp.belgacom.be ([195.238.4.200]:60562 "EHLO
	outmx019.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S965256AbWJCFlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 01:41:35 -0400
Date: Tue, 3 Oct 2006 07:41:18 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, Samuel Tardieu <sam@rfc1149.net>,
       Ben Dooks <ben-linux@fluff.org>, Vitaly Wool <vitalywool@gmail.com>,
       Jiri Slaby <jirislaby@gmail.com>, Alan Cox <alan@redhat.com>
Subject: Re: [WATCHDOG] v2.6.19 watchdog patches
Message-ID: <20061003054118.GA2405@infomag.infomag.iguana.be>
References: <20061002212753.GA9556@infomag.infomag.iguana.be> <20061002143625.2143e4e4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002143625.2143e4e4.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> OK by me.
> 
> I notice that you're holding back a couple of drivers:
> drivers/char/watchdog/iTCO_wdt.c and
> drivers/char/watchdog/smsc37b787_wdt.c.  Not ready yet?

I'm awaiting feedback om the smsc37b787_wdt.c driver
from Sven (about the spin_lock's, just to be sure that
we didn't make any mistakes).

Also w83697hf_wdt should be added, Sam and Marcus
wrote their drivers at almost the same moment.
Sam tested the latest version, but I'm going to ask
Marcus also to test the latest driver.

The iTCO_wdt driver will probably follow this evening.

Greetings,
Wim.

Note: I will also rebuild the -mm tree tonight so that
it's back in sync with linus' tree.

