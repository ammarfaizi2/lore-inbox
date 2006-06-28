Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWF1AZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWF1AZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 20:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWF1AZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 20:25:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932424AbWF1AZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 20:25:55 -0400
Date: Tue, 27 Jun 2006 17:29:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: minyard@acm.org
Cc: linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
       wim@iguana.be
Subject: Re: [PATCH] watchdog: add pretimeout ioctl
Message-Id: <20060627172908.2116a1fa.akpm@osdl.org>
In-Reply-To: <20060627182225.GD10805@localdomain>
References: <20060627182225.GD10805@localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

minyard@acm.org wrote:
>
> Some watchdog timers support the concept of a "pretimeout" which
> occurs some time before the real timeout.  The pretimeout can
> be delivered via an interrupt or NMI and can be used to panic
> the system when it occurs (so you get useful information instead
> of a blind reboot).
> 
> The IPMI watchdog has had this built in, but this creates a standard
> mechanism for all watchdogs and switches the IPMI driver over to it.

This patch seems to be kinda-sorta already half-present in Wim's
development tree.  Could you take a look at what's in 2.6.17-mm3, see if
any additional work is needed and if so, send a patch against that?

Then we can feed it all in when (or after) Wim does his 2.6.18 merge, which
is hopefully soon..
