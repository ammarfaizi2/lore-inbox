Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268966AbUIQQjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268966AbUIQQjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268937AbUIQPd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:33:28 -0400
Received: from mail.dif.dk ([193.138.115.101]:48313 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268828AbUIQPAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:00:35 -0400
Date: Fri, 17 Sep 2004 16:58:24 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Michael Hunold <hunold@linuxtv.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][4/14] dvb core update
In-Reply-To: <414AF461.4050707@linuxtv.org>
Message-ID: <Pine.LNX.4.61.0409171648270.8300@jjulnx.backbone.dif.dk>
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org>
 <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org>
 <414AF461.4050707@linuxtv.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004, Michael Hunold wrote:

> Date: Fri, 17 Sep 2004 16:27:45 +0200
> From: Michael Hunold <hunold@linuxtv.org>
> To: Linus Torvalds <torvalds@osdl.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
>     Andrew Morton <akpm@osdl.org>
> Subject: Re: [PATCH][2.6][4/14] dvb core update
> 
> 

[...]

> - [DVB] convert C++ comments to C comments

It seems you missed a few, and the patch adds a few itself :  
 
> @@ -662,19 +670,9 @@
>          // sanity check

[...]
 
> +				// no need to poll if the CAM supports IRQs

[...]

> +				// poll mode

[...]

>  	FE_NEEDS_BENDING              = 0x20000000, // frontend requires frequency bending
>  	FE_CAN_RECOVER                = 0x40000000, // frontend can recover from a cable unplug automatically
>  	FE_CAN_MUTE_TS                = 0x80000000  // frontend can stop spurious TS data output

And I'll bet there are probably more if I could be bothered to check the 
actual files.

Besides, didn't C99 make C++ style comments valid for C code as well?  
Does CodingStyle have any oppinion on this?


--
Jesper Juhl <juhl-lkml@dif.dk>


