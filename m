Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbTFNB1C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 21:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265597AbTFNB1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 21:27:02 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:64396 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S264105AbTFNB1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 21:27:00 -0400
Date: Sat, 14 Jun 2003 03:40:38 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: george anzinger <george@mvista.com>
cc: Clemens Schwaighofer <cs@tequila.co.jp>, john stultz <johnstul@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uptime wrong in 2.5.70
In-Reply-To: <3EEA3541.4000909@mvista.com>
Message-ID: <Pine.LNX.4.33.0306140335120.17797-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, george anzinger wrote:

> Clemens Schwaighofer wrote:
> >  22:29:47 up 14667 days, 19:08,  3 users,  load average: 0.00, 0.00, 0.00
>
> Uptime currently reports a conversion of jiffies which is currently
> jacked up to a few seconds short of 32 bits worth of jiffies (for
> testing purposes).
>

That would explain being off by 49 days, 17 hours (or 497 days if
HZ=100).
However, the two reported cases are roughly 295 as much, and I have no
clue about that number.

Tim


