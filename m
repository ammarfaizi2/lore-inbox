Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUEKR5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUEKR5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUEKR5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:57:44 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:28607 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261205AbUEKR5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:57:43 -0400
Subject: Re: weird clock problem
From: john stultz <johnstul@us.ibm.com>
To: nelis@brabys.co.za
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1084282171.8334.46.camel@nelis.brabys.co.za>
References: <1084282171.8334.46.camel@nelis.brabys.co.za>
Content-Type: text/plain
Message-Id: <1084298291.3720.7.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 11 May 2004 10:58:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 06:29, Nelis Lamprecht wrote:
> The problem became evident while copying vast amounts of data across to
> my machine. While I was copying data to it via scp my random
> Xscreensaver kicked in displaying the clock and the first thing I
> noticed was that the clock was advancing at a rapid rate. At the same
> time I could not type anything as it would just repeat everything I
> typed 10 fold. Basically the whole system behaved like it was on
> steroids while I was copying to it and by the time I had finished
> copying the clock was 2hrs ahead of time. With kernel 2.6.5 ntpd would
> work on startup and then die saying no servers could be reached which I
> assume was because my clock was so far off.
> 
> I have since downgraded to 2.6.3 and now ntpd is keeping time as it
> should.

Are you using the ACPI PM timesource? Could you send me your dmesg and
kernel config?

thanks
-john


