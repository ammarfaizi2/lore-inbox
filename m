Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbTFUFD0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 01:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbTFUFD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 01:03:26 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:22491 "EHLO
	dust.p68.rivermarket.wintek.com") by vger.kernel.org with ESMTP
	id S265079AbTFUFDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 01:03:25 -0400
Date: Sat, 21 Jun 2003 00:20:16 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
       Christian Kujau <evil@g-house.de>,
       Daniel Whitener <dwhitener@defeet.com>, johnstul@us.ibm.com,
       Clemens Schwaighofer <cs@tequila.co.jp>
Subject: Re: [patch] fix wrong uptime on non-i386 platforms
In-Reply-To: <Pine.LNX.4.33.0306202341050.7684-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.56.0306201754160.1455@dust>
References: <Pine.LNX.4.33.0306202341050.7684-100000@gans.physik3.uni-rostock.de>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jun 2003, Tim Schmielau wrote:

> Here are most of the missing wall_to_monotonic initializations that the
> non-i386 architectures still need to pick up.
> This should fix the reported uptime inconsistencies.
> 
> Disclaimer: completely untested, since I don't have (most of) the hardware.

Incidently, I haven't had the absurdly high uptime bug strike again since 
the first time it happened.  I'll try out your patch as soon as I get a 
chance.

-- 
Alex Goddard
agoddard@purdue.edu
