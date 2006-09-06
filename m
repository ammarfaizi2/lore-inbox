Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWIFXWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWIFXWO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWIFXWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:22:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:45161 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030199AbWIFXWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:22:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sbOmKnLbog5ZKNoz1dCbG9UP/GQu2Y7i+3wO7md534WBT6Ucb3HNzVJyrza6cXpq2yQ+EhJRnNMHxY31gpRutGbO2wSDh3zYL8Ke3NR4O+/IV5HMh8i4khTMc/JI/kvIXH69J7BU0C+w5t2GrKntPHEkaxhA3g1MFc8nf0KZ4SE=
Message-ID: <f71aedf40609061622i7853ed74oc21757dde559286e@mail.gmail.com>
Date: Wed, 6 Sep 2006 18:22:11 -0500
From: "madhu chikkature" <crmadhu210@gmail.com>
To: "Pierre Ossman" <drzeus-list@drzeus.cx>
Subject: Re: SDIO card support in Linux
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44FE5AAC.6030607@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f71aedf40608310804w75728559ma5fd317e16e94b56@mail.gmail.com>
	 <44F73E37.6030602@drzeus.cx>
	 <f71aedf40609051651k5d36d4fdkb6020685fc366983@mail.gmail.com>
	 <44FE5AAC.6030607@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

What is the kernel version this patch is taken againest?

Regards,
Madhu

On 9/6/06, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> madhu chikkature wrote:
> > Hi Pierre,
> >
> > Here is some piece of code that i wrote for SDIO. I use 2.6.10 kernel
> > and hence i can not really take a diff between the latest kernel
> > version. But this is not really a patch. So, You can just comment on
> > my code. I might later on work on the latest kernel versions based on
> > your comment.I see that there are more discussions happening. Please
> > pont to me if you have some code already written.
> >
> > After your previous mail, i see that i can remove the support for CMD3
> > seperately for SDIO and do it the SD way. But i am not sure how to
> > maintain the list of SDIO cards seperately.Also some hardware as our
> > omap does, can support multiple MMC slots, in such cases one slot can
> > have SDIO and the other MMC. The core needs to cliam the cards from
> > different lists. So you may see some not so correct parts in my code.
> >
>
> Your design is a bit lacking yes as it doesn't properly reuse the
> structures in place. Have a look at the version I'm working on instead.
>
> Rgds
> Pierre
>
>
>
>
>
