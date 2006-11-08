Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423710AbWKHVYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423710AbWKHVYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423785AbWKHVYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:24:07 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:26979 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423710AbWKHVYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:24:05 -0500
Date: Wed, 8 Nov 2006 13:23:33 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][trivial] Kconfig: fix spelling error in config KALLSYMS
 help text
Message-Id: <20061108132333.097abfeb.randy.dunlap@oracle.com>
In-Reply-To: <200611082108.02288.jesper.juhl@gmail.com>
References: <200611082108.02288.jesper.juhl@gmail.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006 21:08:02 +0100 Jesper Juhl wrote:

> Fix a small spelling mistake in the help text for the KALLSYMS config option.

I think that it's neither a typo nor a mistake, just a historical
name, but it should be changed.  Ack.
(I made this same patch about 1 month ago and then trashed it.)


> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  init/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index c8b2624..404e891 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -320,7 +320,7 @@ config SYSCTL_SYSCALL
>   	  you should probably say N here.
>  
>  config KALLSYMS
> -	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
> +	 bool "Load all symbols for debugging/ksymoops" if EMBEDDED
>  	 default y
>  	 help
>  	   Say Y here to let the kernel print out symbolic crash information and

---
~Randy
