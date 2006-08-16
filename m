Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWHPWZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWHPWZP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWHPWZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:25:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38029 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932287AbWHPWZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:25:13 -0400
Date: Wed, 16 Aug 2006 15:25:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dirk <noisyb@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
Message-Id: <20060816152509.166ce663.akpm@osdl.org>
In-Reply-To: <44E3552A.6010705@gmx.net>
References: <44E3552A.6010705@gmx.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 19:26:02 +0200
Dirk <noisyb@gmx.net> wrote:

> I have changed a message that didn't clearly tell the user what was goin
> on...
> 
> Please have a look!
> 
> Thank you,
> Dirk
> 
>
> --- drivers/cdrom/cdrom.c.old	2006-08-16 19:04:11.000000000 +0200
> +++ drivers/cdrom/cdrom.c	2006-08-16 19:04:51.000000000 +0200
> @@ -2455,7 +2455,7 @@
>  		if (tracks.data > 0) return CDS_DATA_1;
>  		/* Policy mode off */
>  
> -		cdinfo(CD_WARNING,"This disc doesn't have any tracks I recognize!\n");
> +		cdinfo(CD_WARNING,"I'm a stupid fuck that will repeat this interesting message while endlessly trying to access the media you just inserted until your CD/DVD burning task is eventually fucked\n");
>  		return CDS_NO_INFO;
>  		}

Please keep the code formatted to fit in an 80-column xterm.  See
Documentation/CodingStyle.  Thanks.

(And you forget the Signed-off-by: line)
