Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbVAKXiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbVAKXiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVAKXen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:34:43 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:27070 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262878AbVAKXeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:34:16 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: 2.6.10-mm2: swsusp problem with resuming on batteries (AMD64)
Date: Wed, 12 Jan 2005 00:34:01 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200501112220.53011.rjw@sisk.pl> <20050111212647.GB1802@elf.ucw.cz> <20050111221412.GC4378@ip68-4-98-123.oc.oc.cox.net>
In-Reply-To: <20050111221412.GC4378@ip68-4-98-123.oc.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501120034.02238.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 11 of January 2005 23:14, Barry K. Nathan wrote:
> > > The box is an Athlon 64 laptop on NForce 3.
> > 
> > Can you try without cpufreq support? If we attempt to do 2GHz on AC
> > power, machine may die ugly death.
> 
> Athlon 64 probably means it's running an x86_64 kernel. Wasn't there
> another thread on lkml about -mm2 swsusp and x86_64?

Yes, there was.

> I wonder if it's  the same problem (or a related one).

The other thread was about the hang caused by the timer driver on suspend 
(which I'm still trying to understand, but it takes time ;-)).

That problem is rather not related to this one, because I'm currently using a 
slightly modified kernel in which the function timer_resume() (that caused 
the hang) is a noop.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
