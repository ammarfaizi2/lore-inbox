Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbVLRDOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbVLRDOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 22:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVLRDOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 22:14:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14984 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932677AbVLRDOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 22:14:25 -0500
Date: Sat, 17 Dec 2005 19:14:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robert Walsh <rjwalsh@pathscale.com>
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 01/13]  [RFC] ipath basic headers
Message-Id: <20051217191417.f16011bb.akpm@osdl.org>
In-Reply-To: <1134859158.20575.82.camel@phosphene.durables.org>
References: <200512161548.jRuyTS0HPMLd7V81@cisco.com>
	<200512161548.aLjaDpGm5aqk0k0p@cisco.com>
	<20051217123827.32f119da.akpm@osdl.org>
	<1134859158.20575.82.camel@phosphene.durables.org>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Walsh <rjwalsh@pathscale.com> wrote:
>
> > I'd be inclined to stick BITS_PER_BYTE into include/linux/types.h.
> 
> Really?  I was just going to suggest removing it, but if sticking it in
> types.h works for you, then fine.
> 

I think it's a readbility thing.

	x += 8;			/* wtf? */

vs

	x += BITS_PER_BYTE;	/* ah! */
