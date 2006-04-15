Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbWDOJOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbWDOJOL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 05:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWDOJOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 05:14:11 -0400
Received: from mgw-ext13.nokia.com ([131.228.20.172]:27495 "EHLO
	mgw-ext13.nokia.com") by vger.kernel.org with ESMTP
	id S1751607AbWDOJOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 05:14:09 -0400
Date: Sat, 15 Apr 2006 11:58:21 +0300 (EEST)
From: Samuel Ortiz <samuel.ortiz@nokia.com>
X-X-Sender: samuel@irie
Reply-To: samuel.ortiz@nokia.com
To: ext Adrian Bunk <bunk@stusta.de>
cc: Jean Tourrilhes <jt@hpl.hp.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] net/irda/irias_object.c: remove unused exports
In-Reply-To: <20060414114446.GL4162@stusta.de>
Message-ID: <Pine.LNX.4.58.0604151157320.1032@irie>
References: <20060414114446.GL4162@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Apr 2006 08:58:15.0272 (UTC) FILETIME=[BB5AAE80:01C6606A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006, ext Adrian Bunk wrote:

> This patch removes the following unused EXPORT_SYMBOL's:
> - irias_find_attrib
> - irias_new_string_value
> - irias_new_octseq_value
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
Looks good to me.

Signed-off-by: Samuel Ortiz <samuel.ortiz@nokia.com>


> ---
>
>  net/irda/irias_object.c |    3 ---
>  1 file changed, 3 deletions(-)
>
> --- linux-2.6.17-rc1-mm2-full/net/irda/irias_object.c.old	2006-04-14 12:37:49.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/net/irda/irias_object.c	2006-04-14 12:39:26.000000000 +0200
> @@ -257,7 +257,6 @@
>  	/* Unsafe (locking), attrib might change */
>  	return attrib;
>  }
> -EXPORT_SYMBOL(irias_find_attrib);
>
>  /*
>   * Function irias_add_attribute (obj, attrib)
> @@ -484,7 +483,6 @@
>
>  	return value;
>  }
> -EXPORT_SYMBOL(irias_new_string_value);
>
>  /*
>   * Function irias_new_octseq_value (octets, len)
> @@ -519,7 +517,6 @@
>  	memcpy(value->t.oct_seq, octseq , len);
>  	return value;
>  }
> -EXPORT_SYMBOL(irias_new_octseq_value);
>
>  struct ias_value *irias_new_missing_value(void)
>  {
>
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

