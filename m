Return-Path: <linux-kernel-owner+willy=40w.ods.org-S284681AbUKASER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S284681AbUKASER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbUKARz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:55:56 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:23329 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262451AbUKARyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:54:06 -0500
Date: Mon, 1 Nov 2004 19:54:21 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kernel-doc: don't print "..." twice in variadic functions.
Message-ID: <20041101185421.GC24639@mars.ravnborg.org>
Mail-Followup-To: Alexey Dobriyan <adobriyan@mail.ru>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <E1CONOs-00009g-00.adobriyan-mail-ru@f29.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CONOs-00009g-00.adobriyan-mail-ru@f29.mail.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 12:38:10AM +0300, Alexey Dobriyan wrote:
> --- a/scripts/kernel-doc	2004-10-31 20:25:16.000000000 +0000
> +++ b/scripts/kernel-doc	2004-10-31 22:57:20.061852472 +0000
> @@ -1398,7 +1398,7 @@
>  
>  	if ($type eq "" && $param eq "...")
>  	{
> -	    $type="...";
> +	    $type="";
>  	    $param="...";
>  	    $parameterdescs{"..."} = "variable arguments";
>  	}

Applied

	Sam
