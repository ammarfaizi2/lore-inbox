Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVICWqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVICWqw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 18:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVICWqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 18:46:52 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:2280 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751280AbVICWqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 18:46:52 -0400
Date: Sat, 3 Sep 2005 18:44:12 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [WATCHDOG] v2.6.13 watchdog-patches
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christer Weinigel <wingel@nano-system.com>,
       Deepak Saxena <dsaxena@plexity.net>, Olaf Hering <olh@suse.de>,
       Dimitry Andric <dimitry.andric@tomtom.com>,
       Ben Dooks <ben-linux@fluff.org>, "P @ Draig Brady" <P@draigBrady.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200509031845_MC3-1-A911-6BE6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1125778302.3223.29.camel@laptopd505.fenrus.org>

On Sat, 03 Sep 2005 at 22:11:41 +0200, Arjan van de Ven wrote:

> this looks ENTIRELY like the wrong solution!
> Isn't it a LOT easier to just del_timer_sync() the timer from the module
> exit code?

 But we want to prevent module unload so the timer can fire properly.

__
Chuck
