Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269231AbUIHSCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269231AbUIHSCa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269255AbUIHSCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:02:30 -0400
Received: from slartibartfast.pa.net ([66.59.111.182]:12211 "EHLO
	slartibartfast.pa.net") by vger.kernel.org with ESMTP
	id S269231AbUIHSC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:02:27 -0400
Date: Wed, 8 Sep 2004 13:58:28 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: Ram Chandar <rcknl@qz.port5.com>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
Subject: Re: Linux Routing Performance inferior?
In-Reply-To: <200409071000.58455.rchandar-knl@qz.port5.com>
Message-ID: <Pine.LNX.4.58.0409081354470.2985@sparrow>
References: <200409071000.58455.rchandar-knl@qz.port5.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon, Ram,

On Wed, 8 Sep 2004, Ram Chandar wrote:

> Quoted from a recent mail to freebsd mailing list.
> 
> "FreeBSD (5.x) can route 1Mpps on a 2.8G Xeon while
> Linux can't do much more than 100kpps"
> 
> http://lists.freebsd.org/pipermail/freebsd-net/2004-September/004840.html
> 
> Is this indeed the case?

	I'm sure others here have far better examples, but one post to the 
netfilter-devel list last December provided an example of a firewall that 
could process 580kpps with netfilter/conntrack turned off.  Granted, the 
post noted that adding netfilter brought that down to 450kpps, and adding 
conntrack on top of that brought it down to 295kpps, but all three of 
those numbers are well over the claimed 100kpps.
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "While it may be true that a watched pot never boils, the one
you don't keep an eye on can make an awful mess of your stove."
        -- Edward Stevenson 
(Courtesy of Slashdot)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------
