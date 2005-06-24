Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbVFXI7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbVFXI7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 04:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262975AbVFXI7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 04:59:08 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:5808 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263016AbVFXI5b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 04:57:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MJHXBMPoawJiK3IPuBB+kJANc3A44UsBhYfSTQ723UTw7Xvms9nHWSW891B8iwXc9rluXh5i9XCrhlTRDXEHe9Sg8dwpwzItr7lReWKD47duznBX82MFO5Qdv3vEDRZo9WB4Ie1MrHikgxMqXJkYwEJeJgS0vGOXqiLM/q7LdrQ=
Message-ID: <2cd57c90050624015768bb570e@mail.gmail.com>
Date: Fri, 24 Jun 2005 16:57:30 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] Kernel .patches support
Cc: Christian Hesse <mail@earthworm.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050624073624.GB26545@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506232358.34897.mail@earthworm.de>
	 <20050624073624.GB26545@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/05, Adrian Bunk <bunk@stusta.de> wrote:
> On Thu, Jun 23, 2005 at 11:58:27PM +0200, Christian Hesse wrote:
> > --- linux-2.6.12+/include/linux/patches.h     1970-01-01 01:00:00.000000000 +0100
> > +++ linux-2.6.12+-patches/include/linux/patches.h     2005-06-23 23:10:15.278685000 +0200
> > @@ -0,0 +1,6 @@
> > +#ifndef _LINUX_PATCHES_H
> > +#define _LINUX_PATCHES_H
> > +
> > +#include <linux/autoconf.h>
> > +
> > +#endif
> >...
> 
> What do you need this file for?
 
I think it should be <linux/config.h>.
-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
