Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbWBQOxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbWBQOxL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030598AbWBQOxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:53:11 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:34214 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030474AbWBQOxK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:53:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=beTivec39FBzPruLKHEtPji2vRUpeCQJrCpJBq5+eIkdTnKEJiT2uoo4GyH0OomFUEtV6Bj6La+t4KaRLcYdhFId7fhvclXSiLsem1f1Sxz2j0ZGmcH7j2xSMozMFV696sPdfPc7/R7SwXrU6WvktKGZqw8LBXcz5NLIe0artiU=
Message-ID: <3b0ffc1f0602170653o2062b2b1i71832c7869455426@mail.gmail.com>
Date: Fri, 17 Feb 2006 09:53:09 -0500
From: Kevin Radloff <radsaq@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [ck] [PATCH] mm: implement swap prefetching (v26)
Cc: Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Bart Samwel <bart@samwel.tk>
In-Reply-To: <200602180126.58519.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602172235.40019.kernel@kolivas.org>
	 <3b0ffc1f0602170618u7a1ad877s337de33c0a8f44f9@mail.gmail.com>
	 <200602180126.58519.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/06, Con Kolivas <kernel@kolivas.org> wrote:
> The discussion was about what size to make the swap prefetching. Since the
> size is not user tunable any more that is not the case. I had an offlist
> discussion with Bart Samwel about it and basically if your drive spins down
> at 5 seconds (which is what commonly happens with laptop mode) you will never
> have an opportunity to prefetch. This means swap prefetch will basically
> always spin up the drive nullifying laptop mode. On balance if you care about
> power more than anything to actually set laptop mode I suspect you wont want
> prefetch using any more power.

Ahh, that's certainly a valid point. Although, it could be said that
since the laptop mode script allows you to set a great number of thing
is a great number of ways to achieve your vision of low power mode,
the effectiveness may actually vary. But I don't comprehend your
definition of "idle" in the patch anyway, so I won't bother even
trying to discuss it. ;)

--
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
