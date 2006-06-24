Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932851AbWFXFzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932851AbWFXFzl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 01:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932852AbWFXFzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 01:55:41 -0400
Received: from mail.gmx.de ([213.165.64.21]:4021 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932851AbWFXFzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 01:55:40 -0400
X-Authenticated: #14349625
Subject: Re: Measuring tools - top and interrupts
From: Mike Galbraith <efault@gmx.de>
To: danial_thom@yahoo.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
References: <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 07:59:23 +0200
Message-Id: <1151128763.7795.9.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 09:58 -0700, Danial Thom wrote:

> And 75K pps may not be "much", but its still at
> least 10% of what the system can handle, so it
> should measure around a 10% load. 2.4 measures
> about 12% load. So the only conclusion is that
> load accounting is broken in 2.6.

For UP, yes.  SMP kernel accounts irq processing time properly.

	-Mike

