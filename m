Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVBCXwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVBCXwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 18:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbVBCXw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 18:52:26 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:21722 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261645AbVBCXv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 18:51:58 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ncunningham@linuxmail.org
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64
Date: Fri, 4 Feb 2005 00:52:28 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, Dominik Brodowski <linux@dominikbrodowski.de>,
       LKML <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
References: <200502021428.12134.rjw@sisk.pl> <200502040015.22457.rjw@sisk.pl> <1107473644.5727.6.camel@desktop.cunninghams>
In-Reply-To: <1107473644.5727.6.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502040052.28992.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 4 of February 2005 00:34, Nigel Cunningham wrote:
> Hi.
> 
> On Fri, 2005-02-04 at 10:15, Rafael J. Wysocki wrote:
> > Instead of trying to blow up the battery I used the patch that forces the CPU
> > to 800 MHz and it apparently survives resuming on batteries - at least 3
> > times out of 3 attempts (I'll try some times more tomorrow).
> > 
> > It seems to boot at 1800 MHz, though, every time, according to
> > cpufreq_resume().
> 
> Sounds like some good work. Is 800 the minimum for your laptop?

Yes, it is.

> I'm just wondering how you know what speed to choose on other systems.

Well, I don't know.  It seems that for k8-based CPUs the minimum is
a reasonable choice, but it apparently is not so for other processors.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
