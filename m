Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSKTTyF>; Wed, 20 Nov 2002 14:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSKTTyF>; Wed, 20 Nov 2002 14:54:05 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:10256 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S261206AbSKTTyE>;
	Wed, 20 Nov 2002 14:54:04 -0500
Date: Wed, 20 Nov 2002 21:00:39 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Margit Schubert-While <margit@margit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI
Message-ID: <20021120200039.GD3636@alpha.home.local>
References: <4.3.2.7.2.20021120111430.00b57300@mail.dns-host.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20021120111430.00b57300@mail.dns-host.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 12:02:03PM +0100, Margit Schubert-While wrote:
> While I take the point that we are talking about a stable kernel
> series, one shouldn't forget that ACPI is configurable :-)

So you mean that anything configurable should get into a stable kernel just
because users are not forced to configure it ?
Unless you have the time to add an option "old ACPI / newer ACPI", you cannot
guarantee that there's no risk to break something. If someone has a PC which
needs ACPI to boot, and only the older one, you'll break it. One of the next
pre-releases would be far more appropriate than an -rc.

BTW, I agree that recent ACPI releases seem far more reliable than the one
in vanilla kernel, and I would also be glad to get them in a near future, but
after .20.

Cheers,
Willy

