Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVAMVa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVAMVa2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVAMV3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:29:25 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:43669 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261715AbVAMVWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:22:50 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.10-mm3: swsusp: out of memory on resume (was: Re: Ho ho ho - Linux v2.6.10)
Date: Thu, 13 Jan 2005 22:22:46 +0100
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <200501131909.26021.rjw@sisk.pl> <20050113195941.GD2599@openzaurus.ucw.cz>
In-Reply-To: <20050113195941.GD2599@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501132222.46726.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 13 of January 2005 20:59, Pavel Machek wrote:
[-- snip --] 
> > > Anyway here's that patch ported to 2.6.10+my_bigdiff (just in case
> > > anyone has the same problem on i386).
> > 
> > Has this patch been ported to x86_64?  Or is there a newer version of it anywhere,
> > or an alternative?
> 
> Was that hugang's patch we were talking about?

Yes.

> Anyway ugly workaround for this is to just try harder to free memory during
> suspend... Just do free_some_memory five times with msleep(200) in between.

I found your patch that added this to free_some_memory(), so I decided I'd try it first.
Then, if "out of memory" problems continue, I'll try  the hugang's patch.

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
