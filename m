Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282655AbRLWNfZ>; Sun, 23 Dec 2001 08:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286884AbRLWNfQ>; Sun, 23 Dec 2001 08:35:16 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:10253 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282655AbRLWNfI>;
	Sun, 23 Dec 2001 08:35:08 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Hellwig <hch@caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DRM 4.0 support for kernel 2.4.17 
In-Reply-To: Your message of "Sun, 23 Dec 2001 13:54:17 BST."
             <20011223135417.A24968@caldera.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Dec 2001 00:34:55 +1100
Message-ID: <24365.1009114495@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001 13:54:17 +0100, 
Christoph Hellwig <hch@caldera.de> wrote:
>On Sun, Dec 23, 2001 at 10:48:36AM +1100, Keith Owens wrote:
>> needs the separate copy of drmlib.  I will not maintain that crud into
>> kbuild 2.5.
>
>ftp.kernel.org/pub/linux/kernel/people/hch/patches/v2.4/2.4.17/linux-2.4.17-drm40-1.patch.bz2
>
>Is a version that is (build-) tested and very similar to your versions, based
>on my 2.4.0-test Makefile.
>
>> Some of the code in $(drmlib-4.0-objs) will need EXPORT_SYMBOLS to work
>> when drm 4.0 drivers are compiled as modules.
>
>I don't consider that a good use of drm 4.0.  If someone wants to fix it
>anyway he/she should do it.  I don't think this compatiblity code needs
>so much attention.

Looks good to me.  The first person who wants drm-4.0 support as a
module has some work to do.  ia64 defconfig has drm-4.0 tdfx built in,
no problem there.

