Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUILWVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUILWVw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 18:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUILWVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 18:21:52 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:11677 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263024AbUILWVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 18:21:50 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: swsusp: kill crash when too much memory is free
Date: Mon, 13 Sep 2004 00:23:09 +0200
User-Agent: KMail/1.6.2
Cc: Stefan Seyfried <seife@suse.de>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz> <200409122316.41601.rjw@sisk.pl> <4144C268.80602@suse.de>
In-Reply-To: <4144C268.80602@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409130023.09277.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 of September 2004 23:40, Stefan Seyfried wrote:
> Rafael J. Wysocki wrote:
> > On Sunday 12 of September 2004 22:42, Pavel Machek wrote:
> 
> >>Does snd-intel8x0 have any suspend/resume support?
> > 
> > It seems it doesn't, but frankly I haven't looked at the code.
> 
> It has intel8x0_suspend() and intel8x0_resume() and works on a lot of
> i386 machines fine, i can play sound while suspending and it will
> continue after resuming on e.g. a Dell D600 or a hp nx5000.

Well, here I have problems with it in both the 32-bit and 64-bit modes (in 
short, pci=routeirq is necessary to make it work).  I think they're 
NForce3-specific and that's why I said "hardware" before.  Now, what you are 
saying kind of confirms this.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
