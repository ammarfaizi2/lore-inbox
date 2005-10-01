Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVJAQ3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVJAQ3L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 12:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVJAQ3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 12:29:11 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:31506 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750814AbVJAQ3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 12:29:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=RHWW6tDoLXXzoM19PEpYCx1LrInwQlxefWcToltzAnLbLDLXnI/tdAKgGb0HAollP7ctp//faKEEH8JWVcOj2OaHjJD4iV5MBF5W0Iu3IJd19R6T0puVoC+dUFDmO4tBIJjRpDhL8Fa6PMH/AW9nO3ZNWjElifb1YmDUkBD5F+0=
Date: Sat, 1 Oct 2005 20:40:19 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Miller <davem@davemloft.net>, neilb@cse.unsw.edu.au,
       trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] net/sunrpc/: possible cleanups
Message-ID: <20051001164019.GB8633@mipter.zuzino.mipt.ru>
References: <20051001142041.GB4212@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051001142041.GB4212@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2005 at 04:20:41PM +0200, Adrian Bunk wrote:
> -/* Just increments the mechanism's reference count and returns its input: */
> -struct gss_api_mech * gss_mech_get(struct gss_api_mech *);
> -

> -struct gss_api_mech *
> +static struct gss_api_mech *
>  gss_mech_get(struct gss_api_mech *gm)

Comment is lost.

