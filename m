Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbRLGR1s>; Fri, 7 Dec 2001 12:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284263AbRLGR1i>; Fri, 7 Dec 2001 12:27:38 -0500
Received: from www.transvirtual.com ([206.14.214.140]:35599 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S284204AbRLGR10>; Fri, 7 Dec 2001 12:27:26 -0500
Date: Fri, 7 Dec 2001 09:27:16 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Kirk Reiser <kirk@braille.uwo.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1pre6 vt_kern.h a small patch take 2
In-Reply-To: <x7wuzzjade.fsf_-_@speech.braille.uwo.ca>
Message-ID: <Pine.LNX.4.10.10112070926390.2763-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IMO MAX_NR_CONSOLES should be moved to vt_kern.h

> --- linux/include/linux/vt_kern.h~	Wed Dec  5 10:12:17 2001
> +++ linux/include/linux/vt_kern.h	Wed Dec  5 10:45:20 2001
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/config.h>
> +#include <linux/tty.h> /* needed for MAX_NR_CONSOLES */
>  #include <linux/vt.h>
>  #include <linux/kd.h>

