Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVEYVi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVEYVi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 17:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVEYVi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 17:38:28 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:60686 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261171AbVEYVi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 17:38:26 -0400
Date: Wed, 25 May 2005 14:43:16 -0700
To: Tom Vier <tmv@comcast.net>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050525214316.GA30987@nietzsche.lynx.com>
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050525205841.GB28913@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525205841.GB28913@zero>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 04:58:41PM -0400, Tom Vier wrote:
> If irqs are run in threads, which are scheduled, how are they scheduled?
> fifo? What's the point then; simply to let the top half run to completion
> before another top half starts? If it's about setting scheduling priorities
> for irq threads, some one top half can prempt another, why not just use irq
> levels, like bsd (using pic's is slower than using threads?)?

The point is to have explicit scheduler control this kind with relation
to the RT app in question and not bring back retro Vax 11/780 device
drive semantics in the year 2005. Even FreeBSD/DragonFlyBSD has this
stuff removed.

bill

