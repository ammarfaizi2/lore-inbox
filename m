Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVJGLqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVJGLqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 07:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVJGLqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 07:46:25 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:41593 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932267AbVJGLqY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 07:46:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hi9gTnXZd/8cy0pSOEgc1mxB+TY31NbC071ObbHokcLjGkOwkOtvqMW0cns7Nu+1AWT3Vy6T+5y+nBryESfgY4Q3ad+KAd52CKtncq/zz6VSfwEQPrtxBA/7OfWk8Rb89HxPcuftn0PelRpkVO0h3/nPb/9RgR1vqf4u6qsZt8k=
Message-ID: <4d8e3fd30510070446gb6d469bn4502b30d1e14c7e8@mail.gmail.com>
Date: Fri, 7 Oct 2005 13:46:22 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] vm - swap_prefetch-15
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <200510070001.01418.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510070001.01418.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Con Kolivas <kernel@kolivas.org> wrote:
> The last known bugs were addressed in this latest version of the swap
> prefetching patch. Thanks to the testers out there who helped it get this
> far.
>
> -Prefetched pages weren't handled properly by the lru lists.
> -Prefetch groups are now 10 times larger when laptop_mode is enabled thus
> decreasing the amount of time spent prefetching and thus the disk spinning.
> -Documentation as suggested by Ingo Oeser
>
> Incremental patches and latest available here:
> http://ck.kolivas.org/patches/swap-prefetch/
>

Ciao Con,
i downloading right now kernel 2.6.14-rc3 and your latest patch (v15),
in the weekend I'll update my Ubuntu platform and I'll like to compare
performance of vanilla vs vm-swap_prefetch.

Any hint about what kind of instrumentation I could use in order to
get interesting and useful numbers ?

Thanks!

Regards,
--
Paolo
http://technologynews.altervista.org
