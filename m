Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264068AbUDGAab (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 20:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUDGAab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 20:30:31 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:43243 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S264068AbUDGAaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 20:30:22 -0400
Date: Wed, 7 Apr 2004 02:30:01 +0200
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] H8/300 support update (3/3) - others
Message-ID: <20040407003001.GA1487@mars>
References: <m27jwtl6bf.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m27jwtl6bf.wl%ysato@users.sourceforge.jp>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 08:00:20PM +0900, Yoshinori Sato wrote:
> - use new serial driver (drivers/serial/sh-sci.[ch])
> - typo fix
> - add message level
> 
> diff -Nru -X .exclude-diff linux-2.6.5/arch/h8300/Kconfig linux-2.6.5-h8300/arch/h8300/Kconfig
> --- linux-2.6.5/arch/h8300/Kconfig	2004-04-06 17:11:10.000000000 +0900
> +++ linux-2.6.5-h8300/arch/h8300/Kconfig	2004-04-06 17:00:23.000000000 +0900
> @@ -57,17 +57,17 @@
>  config H8300H_AKI3068NET
>  	bool "AE-3068/69"
>  	help
> -	  AKI-H8/3068F / AKI-H8/3069F Flashmicom LAN Board Suppot
> +	  AKI-H8/3068F / AKI-H8/3069F Flashmicom LAN Board Support
>  	  More Information. (Japanese Only)
>  	  <http://akizukidensi.com/catalog/h8.html>
> -	  AE-3068/69 Evalution Board Support
> +	  AE-3068/69 Evaluation Board Support
>  	  More Information.
>  	  <http://www.microtronique.com/ae3069lan.htm>
>  
>  config H8300H_H8MAX
>  	bool "H8MAX"
>  	help
> -	  H8MAX Evalution Board Suooprt
> +	  H8MAX Evaluation Board Suooprt
				   ^^^
Looks like this one managed to sneak through :)

>  	  More Information. (Japanese Only)
>  	  <http://strawberry-linux.com/h8/index.html>
>  
