Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSJVVJb>; Tue, 22 Oct 2002 17:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264860AbSJVVJb>; Tue, 22 Oct 2002 17:09:31 -0400
Received: from mail.zmailer.org ([62.240.94.4]:51595 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S264838AbSJVVJa>;
	Tue, 22 Oct 2002 17:09:30 -0400
Date: Wed, 23 Oct 2002 00:15:35 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Slavcho Nikolov <snikolov@okena.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: feature request - why not make netif_rx() a pointer?
Message-ID: <20021022211535.GZ1111@mea-ext.zmailer.org>
References: <00b201c27a0e$3f82c220$800a140a@SLNW2K>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b201c27a0e$3f82c220$800a140a@SLNW2K>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 05:01:53PM -0400, Slavcho Nikolov wrote:
> Non GPL modules that want to attach themselves between all L2 drivers and
> upper layers would not have to incur a performance loss if netif_rx() is
> made a pointer instead of a function (whether or not NET filters are
> compiled in the kernel).
> Currently control can be easily wrested from netif_rx() and others through
> injection of a few instructions into the running kernel (SMC - self
> modifying code) but decreased performance is one sad consequence.
> Architecture specific maintenance of SMC slows down portability,
> too.
> The following suggestion would lead to the least amount of modifications.

  ftp://zmailer.org/linux/netif_rx.patch

  Done for 2.3.99-pre7-3  but should be easy to port to 2.5.x ...

> S.N.

/Matti Aarnio
