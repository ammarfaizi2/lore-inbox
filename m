Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265225AbUEYU6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUEYU6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbUEYU6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:58:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:396 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265225AbUEYU6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:58:01 -0400
Subject: Re: System clock speed too high - 2.6.3 kernel
From: john stultz <johnstul@us.ibm.com>
To: Joris van Rantwijk <joris@eljakim.nl>
Cc: lkml <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>
In-Reply-To: <Pine.LNX.4.58.0405251112040.30050@eljakim.netsystem.nl>
References: <1E4zj-77w-69@gated-at.bofh.it>
	 <Pine.LNX.4.58.0405251112040.30050@eljakim.netsystem.nl>
Content-Type: text/plain
Message-Id: <1085518688.8653.19.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 25 May 2004 13:58:08 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-25 at 02:22, Joris van Rantwijk wrote:
> Perhaps this should be documented in the kernel config info.
> If there are many systems with this problem, then calibrating the PM timer
> against the PIT timer at boot time (possibly rejecting invalid rates)
> might be an option.

Also your point above is a good one. We probably should do a sanity
check to make sure we're getting a reasonable frequency (however then
we'll probably start having troubles w/ systems that have broken PITs ;)

I'll put it on my todo list, but if you'd like to take a swing at ti and
beat me to the implementation, I wouldn't complain.

thanks
-john


