Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWDNQmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWDNQmH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 12:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWDNQmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 12:42:06 -0400
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:65217 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S1751275AbWDNQmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 12:42:05 -0400
Date: Fri, 14 Apr 2006 09:42:03 -0700
To: Adrian Bunk <bunk@stusta.de>, Samuel.Ortiz@nokia.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] net/irda/irias_object.c: remove unused exports
Message-ID: <20060414164203.GA24146@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20060414114446.GL4162@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060414114446.GL4162@stusta.de>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	You now need to send those patches to :
		Samuel.Ortiz@nokia.com
	Personally, I don't see what this patch buy us...

	Jean

On Fri, Apr 14, 2006 at 01:44:46PM +0200, Adrian Bunk wrote:
> This patch removes the following unused EXPORT_SYMBOL's:
> - irias_find_attrib
> - irias_new_string_value
> - irias_new_octseq_value
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
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
