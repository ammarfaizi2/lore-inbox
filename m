Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756192AbWKRG5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbWKRG5d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 01:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756193AbWKRG5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 01:57:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:61672 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756192AbWKRG5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 01:57:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ZY86/5GaI1xLXzIefrgCx1A/MAYH3ruVKgWpMen9LsMxJR1s4jrketCWGgUiokb4EdcLSCQwS0wMsXDNApoKmC413tzntxIB+UL6uyMotdyuQ6fl6yHo/CKUo2bzxVqp6pgjk8JTNrb7Tq2YsN3g0bP80RGz+yM3X44ABTZNwXQ=
Date: Sat, 18 Nov 2006 15:51:44 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] input: make serio_register_driver() return error code
Message-ID: <20061118065144.GA3093@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org
References: <20061107120605.GA13896@localhost> <d120d5000611070620l5a0731d8jd5778bc8c8b49b2b@mail.gmail.com> <20061108123636.GA14871@localhost> <200611170137.35955.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611170137.35955.dtor@insightbb.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 01:37:34AM -0500, Dmitry Torokhov wrote:
> I think I found a way to handle all errors when registering serio driver.
> What do you think about the patch below?
> 

Looks good to me.
I also tested this patch with my patch 2/4 (which actually checking
the return code of serio_register_driver() for each input driver).

Acked-by: Akinobu Mita <akinobu.mita@gmail.com>
