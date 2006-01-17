Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWAQXlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWAQXlS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWAQXlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:41:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60553 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932398AbWAQXlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:41:16 -0500
Date: Tue, 17 Jan 2006 15:43:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: malattia@linux.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Time: Delay clocksource selection until later in boot
Message-Id: <20060117154307.07f57bbb.akpm@osdl.org>
In-Reply-To: <1137525365.27699.97.camel@cog.beaverton.ibm.com>
References: <1137525365.27699.97.camel@cog.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> 	Delay installing new clocksources until later in boot. This avoids some
> of the clocksource churn that can occur at boot, possibly allowing the
> system to run for a brief time with a bad clocksource.
> 
> This patch resolves the boot time stalls seen by Mattia Dongili.
> 

Except he now thinks that it doesn't.  Do you think the patch is good anyway?
