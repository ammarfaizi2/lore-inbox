Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263082AbTDBRza>; Wed, 2 Apr 2003 12:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263084AbTDBRz3>; Wed, 2 Apr 2003 12:55:29 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:527 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263082AbTDBRz0>; Wed, 2 Apr 2003 12:55:26 -0500
Date: Wed, 2 Apr 2003 19:06:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l: videobuf update
Message-ID: <20030402190649.A1091@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Gerd Knorr <kraxel@bytesex.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <20030402163647.GA24583@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030402163647.GA24583@bytesex.org>; from kraxel@bytesex.org on Wed, Apr 02, 2003 at 06:36:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 06:36:47PM +0200, Gerd Knorr wrote:
>   Hi,
> 
> This is a minor update for the video-buf module.  It does
> export the videobuf_next_field symbol and adds a few debug
> printks.
> 
>   Gerd
> 
> diff -u linux-2.5.66/drivers/media/video/video-buf.c linux/drivers/media/video/video-buf.c
> --- linux-2.5.66/drivers/media/video/video-buf.c	2003-04-02 11:42:51.957723625 +0200
> +++ linux/drivers/media/video/video-buf.c	2003-04-02 11:49:35.894628822 +0200
> @@ -16,6 +16,7 @@
>   * (at your option) any later version.
>   */
>  
> +#include <linux/version.h>

Why do you need this?

