Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWGQWzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWGQWzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 18:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWGQWzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 18:55:38 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:49612 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751224AbWGQWzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 18:55:37 -0400
Message-ID: <44BC1551.7040104@ens-lyon.org>
Date: Mon, 17 Jul 2006 18:55:13 -0400
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Qi Yong <qiyong@fc-cn.com>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] gitignore quilt's files
References: <20060717033850.GA18438@localhost.localdomain>
In-Reply-To: <20060717033850.GA18438@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Qi Yong wrote:
> gitignore: ignore quilt's files.
>  
> Signed-off-by: Qi Yong <qiyong@fc-cn.com>
> ---
>
> diff --git a/.gitignore b/.gitignore
> index 27fd376..21e346a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -33,3 +33,7 @@ include/linux/version.h
>  
>  # stgit generated dirs
>  patches-*
> +
> +# quilt's files
> +patches
> +series
>
>   


Isn't "series" in the "patches/" subdirectory ? With quilt 0.45, the
only quilt files I see in my linux-tree root are patches/ and .pc/

Brice

