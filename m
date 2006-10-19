Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWJSNGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWJSNGz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWJSNGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:06:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20679 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751408AbWJSNGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:06:54 -0400
Subject: Re: [PATCH] genhd fix or ide workaround -- choose one
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: cbou@mail.ru
Cc: kernel-discuss@handhelds.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061019122516.GA9040@localhost>
References: <20061018221506.GA4187@localhost>
	 <1161259553.17335.30.camel@localhost.localdomain>
	 <20061019122516.GA9040@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 14:08:32 +0100
Message-Id: <1161263312.17335.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 16:25 +0400, ysgrifennodd Anton Vorontsov:
> It just happens every time on HP iPaq hx4700. hx4700 have internal CF
> slot, which is working via pxa2xx pcmcia driver.

I can't duplicate this with the ide_cs driver and a laptop.

> Have you read comments inside -fix patch? Imho it's obvious that nobody
> putting driverfs_device second time, but got it twice.

Its also obvious that it currently works on millions of PC systems and
that also needs explaining before any change is made.

