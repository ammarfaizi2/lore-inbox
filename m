Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTGTIGi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 04:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTGTIGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 04:06:38 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:25869 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263319AbTGTIGQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 04:06:16 -0400
Date: Sun, 20 Jul 2003 10:20:41 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon MP Machine check exceptions
Message-ID: <20030720082041.GD643@alpha.home.local>
References: <20030719225935.GA628@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030719225935.GA628@gallifrey>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

You should feed it through Dave Jones' parsemce program. BTW, he already
replied a few months ago to exactly the same report (search 940040000000017a
on google, you have it already decoded :-))

Cheers,
Willy

On Sat, Jul 19, 2003 at 11:59:35PM +0100, Dr. David Alan Gilbert wrote:
> Hi,
>   Is there any information on decoding AMD Athlon MP Machine
> check exceptions?  I can't seem to find the appropriate AMD
> document on their website - it would be nice to know
> if this is RAM or cache or something else that gave it.
> 
> The error reported is:
> 
> Jul 19 21:07:37 gallifrey kernel: MCE: The hardware reports a non fatal,
> correctable incident occurred on CPU 0.
> Jul 19 21:07:37 gallifrey kernel: Bank 2: 940040000000017a
> 
> Thats from 2.5.75 on a dual Athlon MP on a Tyan 760MP motherboard.
> 
> The machine has apparently been running fine for some time now - perhaps
> this is heat related due to the unusually warm weather over here,
> or perhaps it is the machine check polling picking
> up something that has been going dodgy for a while.
> 
> Dave
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
> \ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
