Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVAJUTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVAJUTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVAJUQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:16:54 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:8610 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262473AbVAJUQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:16:16 -0500
Message-ID: <41E2E276.1070309@ens-lyon.fr>
Date: Mon, 10 Jan 2005 21:15:50 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] FUSE - MAINTAINERS, Kconfig and Makefile changes
References: <E1Co4iU-00043y-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1Co4iU-00043y-00@dorka.pomaz.szeredi.hu>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi a écrit :
> This patch adds FUSE filesystem to MAINTAINERS, fs/Kconfig and
> fs/Makefile.
> 
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> --- a/fs/Kconfig	2004-11-20 21:14:44.000000000 +0100
> +++ b/fs/Kconfig	2004-11-20 12:50:30.000000000 +0100
> @@ -492,6 +492,19 @@ config AUTOFS4_FS
>  	  local network, you probably do not need an automounter, and can say
>  	  N here.
>  
> +config FUSE
> +	tristate "Filesystem in Userspace support"

 From what I see in my .config, most file systems have their config option
named CONFIG_FOO_FS. Why wouldn't FUSE follow this model ?

Regards,
Brice
