Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTKFHQC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 02:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTKFHQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 02:16:02 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:30902 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263389AbTKFHQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 02:16:00 -0500
Subject: Re: PATCH: bugfix =?ISO-8859-1?Q?f=FCr?= RadeonFB (against
	2.4.22-ac4, bug in 2.6.0-test9, too)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ronald Lembcke <es186@fen-net.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031105225724.GA21030@defiant.crash>
References: <20031105225724.GA21030@defiant.crash>
Content-Type: text/plain
Message-Id: <1068102899.12704.196.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 18:14:59 +1100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The first patch is a bugfix in radeonfb.
> The bug is in 2.6.0-test9, too. The second red should be blue.
> 
> --- linux-2.4.22-ac4/drivers/video/radeonfb.c	2003-11-05 19:47:16.000000000 +0100
> +++ linux-2.4.22-ac4_patched/drivers/video/radeonfb.c	2003-11-05 22:08:39.000000000 +0100
> @@ -2362,7 +2362,7 @@
>  			disp->visual = FB_VISUAL_DIRECTCOLOR;
>  			v.red.offset = 10;
>  			v.green.offset = 5;
> -			v.red.offset = 0;
> +			v.blue.offset = 0;
>  			v.red.length = v.green.length = v.blue.length = 5;
>  			v.transp.offset = v.transp.length = 0;
>  			break;

Thanks. Applied to my tree.

Ben.




