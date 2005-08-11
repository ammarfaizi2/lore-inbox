Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVHKJDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVHKJDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 05:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbVHKJDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 05:03:31 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:29861 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030230AbVHKJDa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 05:03:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gqSVcTYnwjzaquN9EeNva1yd4YkSNYaI9u0HUkwSwPXpaEjrBZH3+hvFjxMs33e5OSihhjBo1XKJKn0qZ+4AtKF4NFPnRKtXf3oUl6LemnR3nrnnF58D9jfsN34bzwMolAZVCGDNozpaHKWPYeeMCnW9HKSQTvrQb0RfEfo11Mg=
Message-ID: <6b5347dc0508110203345af854@mail.gmail.com>
Date: Thu, 11 Aug 2005 17:03:25 +0800
From: n l <walking.to.remember@gmail.com>
To: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: why the interrupt handler should be marked "static" for it is never called directly from another file.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0508111049010.5385@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6b5347dc05081101334c1a6e3c@mail.gmail.com>
	 <Pine.LNX.4.58.0508111049010.5385@denise.shiny.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see, if a function in a module is not marked by static ,it can be
accessed by any other function in kernel, while , using a static can
avoid it .

thanks a lot !!


2005/8/11, Giuliano Pochini <pochini@denise.shiny.it>:
> 
> 
> On Thu, 11 Aug 2005, n l wrote:
> 
> > could you explain its reason for using static ?
> 
> Anything which is never referenced from another file should be
> static in order to keep namespace pollution low.
> 
> 
> --
> Giuliano.
>
