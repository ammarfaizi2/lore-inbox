Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263344AbTJQJPq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 05:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTJQJPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 05:15:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55056 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263344AbTJQJPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 05:15:45 -0400
Date: Fri, 17 Oct 2003 10:15:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Bradley Chapman <kakadu_croc@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7-mm1
Message-ID: <20031017101541.A24238@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Bradley Chapman <kakadu_croc@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20031016083124.45a171a5.akpm@osdl.org> <20031017070348.46326.qmail@web40911.mail.yahoo.com> <20031017002529.21528bc7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031017002529.21528bc7.akpm@osdl.org>; from akpm@osdl.org on Fri, Oct 17, 2003 at 12:25:29AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 12:25:29AM -0700, Andrew Morton wrote:
> It's not an oops, it's a warning.  cpufreq_register_notifier() is being
> called super-early but is taking a semaphore.  I've asked the cpufreq guys
> if this can be moved to an initcall but received one of those stupid "your
> message is awaiting moderator approval" replies from the mailing list.  I
> gave up at that point.

Not silly.  Your message was oversize - at least you got something back
rather than it being blackholed like lkml does.

I forwarded it on to the list (after cutting out that massive 47K .config
file that was attached), but no one seems to be listening or interested
there.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
