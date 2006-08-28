Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWH1OcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWH1OcI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWH1OcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:32:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:8505 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750966AbWH1OcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:32:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MMCdf7/ZfWl6rmFMbTQbQccQVrAKQ1fUlkfHtdw+aH5M31UAKRGdJGPJdZZU8qdxXpjIDLMMRt8IxCmyGxpee4FPcKH7pHISWpaRk6gWInYzWedU9Q82gFPk1nV1ojUCnSUuHFICEEKc35yGiRNhloKz2hcngoMAECouOfelWUI=
Message-ID: <40f323d00608280732y5e8e4dc1ib104564fe04b790a@mail.gmail.com>
Date: Mon, 28 Aug 2006 16:32:04 +0200
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Jeremy Fitzhardinge" <jeremy@goop.org>
Subject: Re: 2.6.18-rc4-mm[1,2,3] -- Network card not getting assigned an "eth" device name
Cc: "Andrew Morton" <akpm@osdl.org>, "Miles Lane" <miles.lane@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       "David Miller" <davem@davemloft.net>
In-Reply-To: <44F1C899.4020505@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0608270007gc6a919fx9e36562d8023635d@mail.gmail.com>
	 <20060827001943.c559d37d.akpm@osdl.org> <44F1C899.4020505@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/06, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> Andrew Morton wrote:
> > Jeremy reported that a while back too.  I do not know what is causing it
> > and as far as I know no net developers have yet looked into it.
> >
>
> It went away with -rc4-mm[23] for me...
>
I just reproduced it with rc4-mm3, ipw2200 after coming out of
suspend. I'll apply the patch from David Miller and see if anything
shows out in the log.

regards,

Benoit
