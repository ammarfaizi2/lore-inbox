Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWIUFPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWIUFPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 01:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWIUFPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 01:15:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:39027 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750818AbWIUFPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 01:15:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=FL1fJvmsIB+4RwEGLE4XxL+qX8O3Bj/JgyYINbk3fE9BvKLavCQ2iujJKzuuwBx8wGrgbLHfX6nxYnfj8eyR4dFQ44Z4crL0IElvqJqDut9Rbt6360+oL/cUC/NQUCseCP+Y34QWwgEsAe+8EscomniVcrrZmXmcAnyQyclLYCw=
Date: Thu, 21 Sep 2006 09:15:45 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dave Jones <davej@redhat.com>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Andrew Morton <akpm@osdl.org>, Alex Dubov <oakad@yahoo.com>,
       linux-kernel@vger.kernel.org, drzeus-list@drzeus.cx,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/2] [MMC] Driver for TI FlashMedia card reader - source
Message-ID: <20060921051545.GA5244@martell.zuzino.mipt.ru>
References: <20060920060212.7327.qmail@web36712.mail.mud.yahoo.com> <20060919232016.68a02e0e.akpm@osdl.org> <84144f020609192328k4a2b2a70w5b068f49649398d6@mail.gmail.com> <20060920163652.GF30550@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060920163652.GF30550@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 12:36:52PM -0400, Dave Jones wrote:
> On Wed, Sep 20, 2006 at 09:28:05AM +0300, Pekka Enberg wrote:
>  > On 9/20/06, Andrew Morton <akpm@osdl.org> wrote:
>  > > Trivia:
>  >
>  > [snip]
>  >
>  > More trivia:
>  >
>  >   - Unnecessary casts for void pointers
>  >   - Assignment in if statement expression
>
> also
>
> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
>
> Some unnecessary includes there. (config.h & kernel.h are auto-included)

Only config.h (technically, autoconf.h)

