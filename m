Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263128AbVAFXuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbVAFXuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbVAFXqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:46:20 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:4238 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263209AbVAFXlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:41:23 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.10-mm2: swsusp regression
Date: Fri, 7 Jan 2005 00:41:42 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050106002240.00ac4611.akpm@osdl.org> <200501061848.11719.rjw@sisk.pl> <20050106225233.GD2766@elf.ucw.cz>
In-Reply-To: <20050106225233.GD2766@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501070041.43023.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 6 of January 2005 23:52, Pavel Machek wrote:
> Hi!
> 
> > 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm2/
> > > 
> > > - Various minorish updates and fixes
> > 
> > There's an swsusp regression on my box (AMD64) wrt -mm1.  Namely, 
2.6.10-mm2 
> > does not suspend, but hangs solid right after the critical section, 100% 
of 
> > the time.
> 
> can you comment out device_power_{down,up} from
> swsusp_{suspend,resume} and see what happens?

It works just fine.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
