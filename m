Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965334AbWHXB4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965334AbWHXB4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 21:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965336AbWHXB4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 21:56:46 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:64392 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S965334AbWHXB4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 21:56:45 -0400
Date: Thu, 24 Aug 2006 04:01:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Warn about config.h inclusion
Message-ID: <20060824020132.GA16844@uranus.ravnborg.org>
References: <20060823231902.GC5203@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823231902.GC5203@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 03:19:02AM +0400, Alexey Dobriyan wrote:
> Otherwise feature adders won't feel it's unneeded..
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  include/linux/config.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/include/linux/config.h
> +++ b/include/linux/config.h
> @@ -3,6 +3,7 @@ #define _LINUX_CONFIG_H
>  /* This file is no longer in use and kept only for backward compatibility.
>   * autoconf.h is now included via -imacros on the commandline
s/imacros/include/

Try make V=1 to see it.
It was -imacros in the early beginning but due to troubles with some binutils version it was changed IIRC.

     Sam
