Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263382AbTKASdk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 13:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbTKASdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 13:33:39 -0500
Received: from b-195-adc53e.lohjanpuhelin.fi ([62.197.173.195]:28317 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S263382AbTKASdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 13:33:38 -0500
Date: Sat, 1 Nov 2003 20:33:36 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Alexander Chacon <chacona@mechanus.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modular ipv4 inquiries...
Message-ID: <20031101183336.GD26480@mea-ext.zmailer.org>
References: <1067711134.659a9dpacz4s@webmail.mechanus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067711134.659a9dpacz4s@webmail.mechanus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 01, 2003 at 12:25:34PM -0600, Alexander Chacon wrote:
> Hello!
> 
> I would like to know a few things about making the ipv4 code modular. I've been
> working on a school assignment that requires implementing tunneling, but first
> ipv4 must be modularized... it needs to be done using kernel 2.4.20
> 
> .... What should I consider for a start, and how hard can it be
> in the end?

When I did it way back when once, it took me 1 or 2 days to do
basic modularization, where the IPv4 is installable once, and
will stay in forever (like IPv6 is now).  To make it uninstallable
took me another week.

> I've experienced a lot of undefined symbol references which are linked
> to core kernel files!, isn't there a way to access these symbols from 
> the module into the kernel while executing?

Yes.  You need to export them from basic core.

> Thanks in advance
> Alexander Chacon

/Matti Aarnio
