Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUHCOUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUHCOUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 10:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUHCOUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 10:20:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19132 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266324AbUHCOUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 10:20:24 -0400
Date: Tue, 3 Aug 2004 10:19:38 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Shane Shrybman <shrybman@aei.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
In-Reply-To: <1091459297.2573.10.camel@mars>
Message-ID: <Pine.LNX.4.58.0408031019090.20420@devserv.devel.redhat.com>
References: <1091459297.2573.10.camel@mars>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Aug 2004, Shane Shrybman wrote:

> Also, had to turn of parport in the config to get it to compile.
> 
> drivers/parport/share.c:77: unknown field `generic_enable_irq' specified
> in initializer
> drivers/parport/share.c:78: unknown field `generic_disable_irq'
> specified in initializer

thx - i fixed this in -O3.

	Ingo
