Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286886AbRLWMzQ>; Sun, 23 Dec 2001 07:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286887AbRLWMzH>; Sun, 23 Dec 2001 07:55:07 -0500
Received: from ns.caldera.de ([212.34.180.1]:38878 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S286886AbRLWMzA>;
	Sun, 23 Dec 2001 07:55:00 -0500
Date: Sun, 23 Dec 2001 13:54:17 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DRM 4.0 support for kernel 2.4.17
Message-ID: <20011223135417.A24968@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20011222203602.A15825@caldera.de> <17474.1009064916@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <17474.1009064916@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sun, Dec 23, 2001 at 10:48:36AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2001 at 10:48:36AM +1100, Keith Owens wrote:
> needs the separate copy of drmlib.  I will not maintain that crud into
> kbuild 2.5.
> 
> drivers/char/drm-4.0/Makefile below uses the standard kbuild design.
> One copy of drmlib-4.0 which is built into the kernel if any drm 4.0
> drivers are built in, otherwise drmlib-4.0 is a module if there are any
> drm 4.0 modules.  Totally untested.

ftp.kernel.org/pub/linux/kernel/people/hch/patches/v2.4/2.4.17/linux-2.4.17-drm40-1.patch.bz2

Is a version that is (build-) tested and very similar to your versions, based
on my 2.4.0-test Makefile.

> Some of the code in $(drmlib-4.0-objs) will need EXPORT_SYMBOLS to work
> when drm 4.0 drivers are compiled as modules.

I don't consider that a good use of drm 4.0.  If someone wants to fix it
anyway he/she should do it.  I don't think this compatiblity code needs
so much attention.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
