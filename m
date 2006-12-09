Return-Path: <linux-kernel-owner+w=401wt.eu-S1757574AbWLIViQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574AbWLIViQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757289AbWLIViQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:38:16 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52376 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757574AbWLIViP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:38:15 -0500
Date: Sat, 9 Dec 2006 13:42:03 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Stefan Lippers-Hollmann <s.L-H@gmx.de>
Cc: stable@kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Thomas Backlund <tmb@mandriva.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 00/32] -stable review
Message-ID: <20061209214203.GV1397@sequoia.sous-sol.org>
References: <20061208235751.890503000@sous-sol.org> <200612091226.22936.s.L-H@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612091226.22936.s.L-H@gmx.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefan Lippers-Hollmann (s.L-H@gmx.de) wrote:
> At least
> http://kernel.org/pub/linux/kernel/people/chrisw/stable/patch-2.6.19.1-rc1.gz
> and
> http://kernel.org/pub/linux/kernel/people/chrisw/stable/patch-2.6.19.1-rc2.gz
> seem to contain an incompletely applied "[patch 24/32] add bottom_half.h",
> bottom_half.h itself is missing, while interrupt.h and spinlock.h are changed 
> to use the missing file:
> 
> $ wget -qO- http://kernel.org/pub/linux/kernel/people/chrisw/stable/patch-2.6.19.1-rc2.gz | gzip -dc | grep bottom_half
> +#include <linux/bottom_half.h>
> +#include <linux/bottom_half.h>
> $ wget -qO- http://kernel.org/pub/linux/kernel/people/chrisw/stable/patch-2.6.19.1-rc1.gz | gzip -dc | grep bottom_half
> +#include <linux/bottom_half.h>
> +#include <linux/bottom_half.h>

Sorry about that, I regenerated and made sure I picked up new files.
I've pushed up an rc3 (mirroring is a bit slow).

thanks,
-chris
