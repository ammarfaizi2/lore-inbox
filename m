Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVGHXzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVGHXzE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVGHXzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:55:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262806AbVGHXzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 19:55:02 -0400
Date: Fri, 8 Jul 2005 16:55:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@telia.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: Patch for slab leak debugging
Message-Id: <20050708165554.4b958087.akpm@osdl.org>
In-Reply-To: <1120856219.25294.29.camel@localhost.localdomain>
References: <1120856219.25294.29.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@telia.com> wrote:
>
> I think we really need an option in the kernel to help users in tracking
> slab leaks so that they can be brought down easier.

Well we already have slab-leak-detector.patch, whcih I appear to have been
sitting on since 2.6.0-test8.  it fell out of -mm after 2.6.12-rc5-mm2 due
to various ravaging of slab.c, but could be brought back.

pc/2.6.12-rc5-mm2-series:slab-leak-detector.patch
pc/2.6.12-rc5-mm2-series:slab-leak-detector-warning-fixes.patch
