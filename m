Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVFNHap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVFNHap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVFNHap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:30:45 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:27827 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261302AbVFNHaj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:30:39 -0400
X-Envelope-From: kraxel@suse.de
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com
Subject: Re: [PATCH] Adds support for TEA5767 chipset on V4L
References: <42ACAA3B.8050307@brturbo.com.br>
	<20050613183523.322529e0.khali@linux-fr.org>
	<42ADD33F.3020100@brturbo.com.br>
From: Gerd Knorr <kraxel@suse.de>
Organization: SUSE Labs, Berlin
Date: 14 Jun 2005 09:29:42 +0200
In-Reply-To: <42ADD33F.3020100@brturbo.com.br>
Message-ID: <8764wh2y6x.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@brturbo.com.br> writes:

> >>+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> >>+#include "tuner.h"
> >>+#include "i2c-compat.h"
> >>+#else
> >>+#include <media/tuner.h>
> >>+#endif

> >No such test please, it is useless. This is Linux 2.6.x, no need to
> >check this.

>     There's a script to eliminate this before submiting the patch... For
> some reason, as you pointed, it had failed for this code... I'll review
> it next time.

btw: is anyone testing the v4l cvs on 2.4 kernels?  I stopped doing
that quite a while ago, alot of stuff (dvb support) doesn't build on
2.4 kernels anyway, so its probably reasonable to cleanup the code in
cvs as well and simply drop the 2.4 code ...

  Gerd

-- 
-mm seems unusually stable at present.
	-- akpm about 2.6.12-rc3-mm3
