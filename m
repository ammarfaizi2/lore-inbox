Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWAEAwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWAEAwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWAEAvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:51:50 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:11529 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751009AbWAEAvP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:51:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lb943Xy9ZWPJDMiurIz80jbZgE0NTP2NC1HpY55MjG58orHnK0a7FhrF2tXx02ytvRNgonHlquS06APdapts96rMu6aoW0glg2vuHWYcF5242/6z1O7CyHey2IuBNqilNM6V/ORAQ+//LRJ0OQC5RUzbuGFNRn7NLj2xZUhbn+g=
Message-ID: <2cd57c900601041650j6b3e7ea6u@mail.gmail.com>
Date: Thu, 5 Jan 2006 08:50:40 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH 2.6.15-rc7] aoe [4/7]: use less confusing driver name
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
In-Reply-To: <87mziclztq.fsf@coraid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87hd8l2fb4.fsf@coraid.com> <871wzp10lm.fsf@coraid.com>
	 <2cd57c900601032202y3de62e78m@mail.gmail.com>
	 <87mziclztq.fsf@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/1/5, Ed L Cashin <ecashin@coraid.com>:
> Coywolf Qi Hunt <coywolf@gmail.com> writes:
>
> > 2006/1/4, Ed L. Cashin <ecashin@coraid.com>:
> >> Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
> >>
> >> Users were confused by the driver being called "aoe-2.6-$version".
> >> This form looks less like a Linux kernel version number.
> >>
> >> Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoemain.c
> >> ===================================================================
> >> --- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoemain.c     2006-01-02 13:35:13.000000000 -0500
> >> +++ 2.6.15-rc7-aoe/drivers/block/aoe/aoemain.c  2006-01-02 13:35:14.000000000 -0500
> >> @@ -89,7 +89,7 @@
> >>         }
> >>
> >>         printk(KERN_INFO
> >> -              "aoe: aoe_init: AoE v2.6-%s initialised.\n",
> >> +              "aoe: aoe_init: aoe6-%s initialised.\n",
> >>                VERSION);
> >
> > Better simply be `AoE v%s'?
>
> That would be nice, but there's a driver for the 2.4 linux kernel that
> has an independent version number, so the "6" distinguishes the 2.6
> aoe driver from the 2.4 aoe driver.

But 2.4 and 2.6 driver never meet each other, right?

>
> --
>   Ed L Cashin <ecashin@coraid.com>
>
>

--
Coywolf Qi Hunt
