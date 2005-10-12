Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVJLBZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVJLBZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 21:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVJLBZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 21:25:37 -0400
Received: from cncln.online.ln.cn ([218.25.172.144]:39435 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932393AbVJLBZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 21:25:36 -0400
Date: Wed, 12 Oct 2005 09:25:28 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] small Kconfig help text correction for CONFIG_FRAME_POINTER
Message-ID: <20051012012528.GA2845@localhost.localdomain>
References: <200510112322.22004.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510112322.22004.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 11:22:21PM +0200, Jesper Juhl wrote:
> Fix-up the CONFIG_FRAME_POINTER help text language a bit.
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  "on some architectures or you use external debuggers"
>   doesn't sound too good
>  "on some architectures or if you use external debuggers"
>   is better.


Why bother anyway since the original is brief and neat.  (yours could be s/if/when/ even)


		Coywolf

> 
>  lib/Kconfig.debug |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.14-rc4-orig/lib/Kconfig.debug	2005-10-11 22:41:32.000000000 +0200
> +++ linux-2.6.14-rc4/lib/Kconfig.debug	2005-10-11 23:16:30.000000000 +0200
> @@ -174,7 +174,7 @@
>  	default y if DEBUG_INFO && UML
>  	help
>  	  If you say Y here the resulting kernel image will be slightly larger
> -	  and slower, but it might give very useful debugging information
> -	  on some architectures or you use external debuggers.
> +	  and slower, but it might give very useful debugging information on
> +	  some architectures or if you use external debuggers.
>  	  If you don't debug the kernel, you can say N.
>  
> 
> 
> -
