Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265011AbUETIB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265011AbUETIB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 04:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbUETIBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 04:01:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7325 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265011AbUETIBx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 04:01:53 -0400
Message-ID: <40AC65E5.40403@pobox.com>
Date: Thu, 20 May 2004 04:01:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] doc update for bk usage
References: <1085036543.24931.154.camel@bach>
In-Reply-To: <1085036543.24931.154.camel@bach>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
>  From:  carbonated beverage <ramune@net-ronin.org>
> 
> ---
>   bk://... appears to be dead, use http://... instead.
>   
>   ===== Documentation/BK-usage/bk-kernel-howto.txt 1.7 vs edited =====
> 
> --- trivial-2.6.6-bk6/Documentation/BK-usage/bk-kernel-howto.txt.orig	2004-05-20 15:59:35.000000000 +1000
> +++ trivial-2.6.6-bk6/Documentation/BK-usage/bk-kernel-howto.txt	2004-05-20 15:59:35.000000000 +1000
> @@ -279,5 +279,5 @@
>     for my long-lived kernel branch?
>  A. Yes.  This requires BK 3.x, though.
>  
> -	bk export -tpatch -r`bk repogca bk://linux.bkbits.net/linux-2.5`,+
> +	bk export -tpatch -r`bk repogca http://linux.bkbits.net/linux-2.5`,+
>  
> --- trivial-2.6.6-bk6/Documentation/BK-usage/gcapatch.orig	2004-05-20 15:59:35.000000000 +1000
> +++ trivial-2.6.6-bk6/Documentation/BK-usage/gcapatch	2004-05-20 15:59:35.000000000 +1000
> @@ -5,4 +5,4 @@
>  # Usage: gcapatch > foo.patch
>  #
>  
> -bk export -tpatch -hdu -r`bk repogca bk://linux.bkbits.net/linux-2.5`,+
> +bk export -tpatch -hdu -r`bk repogca http://linux.bkbits.net/linux-2.5`,+


NAK.

It's not dead, as I just re-verified (and usually do so daily).

I'm the doc's author, though don't claim to be it's maintainer, FWIW ;-)

	Jeff



