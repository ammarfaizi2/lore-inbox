Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbTA1S4R>; Tue, 28 Jan 2003 13:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267473AbTA1S4R>; Tue, 28 Jan 2003 13:56:17 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:530 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267466AbTA1S4Q>; Tue, 28 Jan 2003 13:56:16 -0500
Date: Tue, 28 Jan 2003 19:05:34 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Faik Uygur <faikuygur@ttnet.net.tr>
cc: linux-kernel@vger.kernel.org, <andreashappe@gmx.net>
Subject: Re: [PATCH] 2.5.59: radeonfb, no visible cursor at the fb console
In-Reply-To: <20030127220655.GA7650@ttnet.net.tr>
Message-ID: <Pine.LNX.4.44.0301281905260.12076-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied. Thanks.

> This trivial patch fixes the cursor problem at radeonfb.c, reported at
> http://bugme.osdl.org/show_bug.cgi?id=292
> 
> --- linux-2.5.59-vanilla/drivers/video/radeonfb.c       Mon Jan 27 23:25:39 2003
> +++ linux-2.5.59/drivers/video/radeonfb.c       Mon Jan 27 23:44:02 2003
> @@ -2212,6 +2212,7 @@
>         .fb_copyarea    = cfb_copyarea,
>         .fb_imageblit   = cfb_imageblit,
>  #endif
> +       .fb_cursor      =  soft_cursor,
>  };
> 

