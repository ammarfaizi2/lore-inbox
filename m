Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVA2TOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVA2TOv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVA2TMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:12:19 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:63950 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261544AbVA2TIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:15 -0500
Date: Sat, 29 Jan 2005 12:28:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries.Brouwer@cwi.nl
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] document atkbd.softraw
Message-ID: <20050129112805.GC2268@ucw.cz>
References: <200501282323.j0SNNFF23250@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501282323.j0SNNFF23250@apps.cwi.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 12:23:15AM +0100, Andries.Brouwer@cwi.nl wrote:

> Document atkbd.softraw (and shorten a few long lines nearby).

Thanks, applied.

> --- a/Documentation/kernel-parameters.txt	2004-12-29 03:39:42.000000000 +0100
> +++ b/Documentation/kernel-parameters.txt	2005-01-29 00:21:07.000000000 +0100
> @@ -222,15 +222,19 @@ running once the system is up.
>  
>  	atascsi=	[HW,SCSI] Atari SCSI
>  
> -	atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess, EzKey
> -			and similar keyboards
> +	atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess,
> +			EzKey and similar keyboards
>  
>  	atkbd.reset=	[HW] Reset keyboard during initialization
>  
>  	atkbd.set=	[HW] Select keyboard code set 
>  			Format: <int> (2 = AT (default) 3 = PS/2)
>  
> -	atkbd.scroll=	[HW] Enable scroll wheel on MS Office and similar keyboards
> +	atkbd.scroll=	[HW] Enable scroll wheel on MS Office and similar
> +			keyboards
> +
> +	atkbd.softraw=	[HW] Choose between synthetic and real raw mode
> +			Format: <bool> (0 = real, 1 = synthetic (default))
>  	
>  	atkbd.softrepeat=
>  			[HW] Use software keyboard repeat
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
