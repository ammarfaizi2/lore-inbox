Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266331AbUAHWaZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUAHWaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:30:24 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:42674 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S266331AbUAHWaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:30:20 -0500
Date: Thu, 8 Jan 2004 23:28:08 +0100
To: Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.1-rc3] Canonically reference files in Documentation/, code comments part
Message-ID: <20040108222808.GC785@mars>
References: <86ad4y70n2.fsf@n-dimensional.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ad4y70n2.fsf@n-dimensional.de>
User-Agent: Mutt/1.5.4i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 07:31:29PM +0100, Hans Ulrich Niedermann wrote:
> diff -Nru a/drivers/usb/misc/tiglusb.c b/drivers/usb/misc/tiglusb.c
> --- a/drivers/usb/misc/tiglusb.c	Thu Jan  8 18:48:58 2004
> +++ b/drivers/usb/misc/tiglusb.c	Thu Jan  8 18:48:58 2004
> @@ -10,7 +10,7 @@
>   *
>   * Based on dabusb.c, printer.c & scanner.c
>   *
> - * Please see the file: linux/Documentation/usb/SilverLink.txt
> + * Please see the file: Documentation/usb/SilverLink.txt

Documentation/silverlink.txt

> diff -Nru a/fs/hfs/FAQ.txt b/fs/hfs/FAQ.txt
> --- a/fs/hfs/FAQ.txt	Thu Jan  8 18:48:58 2004
> +++ b/fs/hfs/FAQ.txt	Thu Jan  8 18:48:58 2004
> @@ -264,7 +264,7 @@
>    mount option.  More information is provided in the ``afpd'' subsection
>    of the ``Mount Options'' section of the HFS documentation (HFS.txt if
>    you have the stand-alone HFS distribution or
> -  linux/Documentation/filesystems/hfs.txt if HFS is in your kernel
> +  Documentation/filesystems/hfs.txt if HFS is in your kernel
>    source tree.)

Ok, these are not in Documentation/ like they should be (funny how they
reference themselves there :) but rather in fs/hfs/.

> diff -Nru a/sound/oss/via82cxxx_audio.c b/sound/oss/via82cxxx_audio.c
> --- a/sound/oss/via82cxxx_audio.c	Thu Jan  8 18:48:58 2004
> +++ b/sound/oss/via82cxxx_audio.c	Thu Jan  8 18:48:58 2004
> @@ -10,7 +10,7 @@
>   * NO WARRANTY
>   *
>   * For a list of known bugs (errata) and documentation,
> - * see via-audio.pdf in linux/Documentation/DocBook.
> + * see via-audio.pdf in Documentation/DocBook.
>   * If this documentation does not exist, run "make pdfdocs".
>   */

True only if we did `make pdfdocs'. Perhaps this should be via-audio.tmpl?

Great work.

	Arthur
-- 
Linux is a true multitasking system. Are you?
