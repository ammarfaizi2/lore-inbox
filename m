Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275054AbTHIQaJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 12:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275065AbTHIQaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 12:30:09 -0400
Received: from [62.29.76.86] ([62.29.76.86]:16512 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S275054AbTHIQaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 12:30:04 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Thomas Molina <tmolina@cablespeed.com>
Subject: Re: Linux 2.6.0-test3: logo patch
Date: Sat, 9 Aug 2003 19:28:20 +0300
User-Agent: KMail/1.5.9
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <Pine.LNX.4.44.0308091059490.2587-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0308091059490.2587-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308091927.04894.kde@myrealbox.com>
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-1=22?=
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch somehow got out of -mm tree too. Andrew can you please apply this  too ?
> The following patch has been floating around forever.  Can we get it in
> mainstream sometime in the near future?
>
> --- linux-2.5-tm/drivers/video/cfbimgblt.c.orig	2003-08-08
> 17:42:16.000000000 -0500 +++
> linux-2.5-tm/drivers/video/cfbimgblt.c	2003-08-08 17:42:30.000000000 -0500
> @@ -325,7 +325,7 @@
>  		else
>  			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
>  					start_index, pitch_index);
> -	} else if (image->depth == bpp)
> +	} else if (image->depth <= bpp)
>  		color_imageblit(image, p, dst1, start_index, pitch_index);
>  }
>
>

