Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVFOABK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVFOABK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 20:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVFOABK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 20:01:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52372 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261429AbVFOABF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 20:01:05 -0400
Date: Tue, 14 Jun 2005 17:01:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: mchehab@brturbo.com.br, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH3/5] Synchronize patch for SAA7134 cards
Message-Id: <20050614170137.690e0328.akpm@osdl.org>
In-Reply-To: <42ABC3C4.4050406@brturbo.com.br>
References: <42ABBE6F.8080406@brturbo.com.br>
	<42ABC3C4.4050406@brturbo.com.br>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
>
> --- linux-2.6.12/drivers/media/video/saa7134/saa7134-video.c	2005-06-07 15:39:55.000000000 -0300
> +++ linux/drivers/media/video/saa7134/saa7134-video.c	2005-06-12 01:22:34.000000000 -0300
> @@ -1,5 +1,5 @@
>  /*
> ...
>  		.h_start       = 0,
>  		.h_stop        = 719,
> - 		.video_v_start = 23,
> - 		.video_v_stop  = 262,
> - 		.vbi_v_start_0 = 10,
> - 		.vbi_v_stop_0  = 21,
> - 		.vbi_v_start_1 = 273,
> - 		.src_timing    = 7,
> -
> +		.video_v_start = 22,
> +  		.video_v_start = 23,

That doesn't compile.  I'll assume it's supposed to be 22.
