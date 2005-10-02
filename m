Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbVJBHCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbVJBHCo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 03:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbVJBHCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 03:02:44 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:17479 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750996AbVJBHCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 03:02:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=huEwliz2kpk7lTGJXj9UXQZIq2YGR4AkZ7ftxRiLOJ03tt4Zq10h4lQt4bz9bK12iZ2nT9PSzK05myeJtZS/a+iEIDMhTohN738AzqLY6UoWBrHj/vAi58wH8h+Y3CHAbl2hdQXJJGn/lr85xZsGkCUwaBJQVD9keoGgx1wzaQI=
Message-ID: <433F860C.7050807@gmail.com>
Date: Sun, 02 Oct 2005 15:02:36 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] Document from line in patch format
References: <20051002062135.32334.32895.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051002062135.32334.32895.sendpatchset@jackhammer.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Document more details of patch format such as the "from" line
> used to specify the patch author, and provide more references
> for patch guidelines.
> 
> Signed-off-by: Paul Jackson <pj@sgi.com>
> 
> Index: 2.6.14-rc2-mm2/Documentation/SubmittingPatches
> ===================================================================
> --- 2.6.14-rc2-mm2.orig/Documentation/SubmittingPatches
> +++ 2.6.14-rc2-mm2/Documentation/SubmittingPatches
> @@ -301,8 +301,47 @@ now, but you can do this to mark interna
>  point out some special detail about the sign-off. 
>  
>  
> +12) The canonical patch format
>  
> -12) More references for submitting patches
> +The canonical patch subject line is:
> +
> +    Subject: [PATCH 001/123] [<area>:] <explanation>
> +
> +The canonical patch message body contains the following:
> +
> +    The first line of the body contains a "from" line specifying
> +    the author of the patch:
> +
> +        From: Original Author <author@email.com>
> +
> +    If the "from" line is missing, then the author of the patch will
> +    be recorded in the source code revision history as whomever is
> +    listed in the last "Signed-off-by:" line in the message when Linus
                     ^^^^ 
Shouldn't this be the first?

Tony
