Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269183AbUJFKEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269183AbUJFKEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 06:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUJFKEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 06:04:25 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:41653 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269183AbUJFKEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 06:04:23 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3[+recent swsusp patches]: swsusp kernel-preemption-unfriendly?
Date: Wed, 6 Oct 2004 12:06:56 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>
References: <200410052314.25253.rjw@sisk.pl> <200410061055.39698.rjw@sisk.pl> <20041006085458.GC1255@elf.ucw.cz>
In-Reply-To: <20041006085458.GC1255@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410061206.56025.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 of October 2004 10:54, Pavel Machek wrote:
> Hi!
> 
> > > > It looks like there's a probel with the kernel preemption vs swsusp:
> > > 
> > > It is not in kernel preemption, see that NULL pointer dereference? Try
> > > this one...
> > [-- snip --]
> > 
> > Is it against -mm?  It does not apply cleanly to -rc3, so I've applied it 
> > manually.
> 
> It was against -suse... Did it help?

I just can't say it didn't right now.  The Oops was not readily reproducible 
anyway, so I need to do some more suspend/resume testing.  I'll let you 
know. ;-)

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
