Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316082AbSEJRz6>; Fri, 10 May 2002 13:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316084AbSEJRz5>; Fri, 10 May 2002 13:55:57 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:43482 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316082AbSEJRz5>; Fri, 10 May 2002 13:55:57 -0400
Date: Fri, 10 May 2002 13:55:52 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200205101755.g4AHtqw04422@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Tcp/ip offload card driver
In-Reply-To: <mailman.1021046154.26338.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> For example, do a SpecWEB run with TUX both using on-chip-TCP and
> without, same networking card.  Show a demonstrable gain from the
> on-chip-TCP implementation.  I bet you can't.

NO! Doing such a test sets you up for a failure. If a vendor
of the card provides an on-chip TCP, it is entirely in the
vendor's interest to penalize regular TCP (for example, by
failing to provide checksum offload or sane S/G segments).

I only consider fair a test of on-chip TCP compared to
the best of the normal NICs.

-- Pete
