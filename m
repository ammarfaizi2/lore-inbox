Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUIZWD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUIZWD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 18:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUIZWD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 18:03:28 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:35269 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264113AbUIZWDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 18:03:24 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Date: Mon, 27 Sep 2004 00:05:04 +0200
User-Agent: KMail/1.6.2
Cc: Stefan Seyfried <seife@suse.de>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>
References: <200409251214.28743.rjw@sisk.pl> <200409262125.38271.rjw@sisk.pl> <41572B34.3010209@suse.de>
In-Reply-To: <41572B34.3010209@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409270005.04458.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 of September 2004 22:48, Stefan Seyfried wrote:
> Rafael J. Wysocki wrote:
> 
> >>Try to unload all modules etc, see if it goes away.
> > 
> > I guess it will, but I'll check.
> 
> please try attached patch first. The comments should explain it pretty
> well. It seems to have helped me: without it, sysrq-p during writing
> (even if not that slow) almost always was in pccardd, now it is idling
> in swapper task.
> Maybe i am totally wrong but you may give it a shot.

Does not help, sorry. :-(

> >>If not, fix sysrq  to work for you, and look at backtrace.
> > 
> > This would be more time-consuming. :-)
> 
> maybe you just press wrong keys? On my Dell D600, although SysRQ is in
> blue on PrtSc, no Fn-Key is needed but only ALT-PrtSc.

It is possible, but I have two x86-64 boxes, one of which is a regular PC with 
no Fn-Key whatsoever, and it doesn't work on both, apparently.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
