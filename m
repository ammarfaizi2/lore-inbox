Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVCPJg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVCPJg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 04:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVCPJg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 04:36:57 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:44686 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262304AbVCPJgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 04:36:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HB7UWi0X3KstVx5sh9//u7v9JMKTYHqxZQTAbw4Iky14p99u0X41bC2xus3TWYO88AZyFZAzAfL24QcctdWW4rfTFAVcNLsiQSrilZt80H7vpnTnWd1MzibuSUmQLax5Wlrwzd3ytDzbGYGL5NIl398k66pfPtvrqeG929vdOV4=
Message-ID: <21d7e99705031601363f27296@mail.gmail.com>
Date: Wed, 16 Mar 2005 09:36:49 +0000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: 2.6.11-mm3 - DRM/i915 broken
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <423616CF.6060204@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050312034222.12a264c4.akpm@osdl.org> <42360820.702@ens-lyon.org>
	 <200503142330.42556.bero@arklinux.org> <423616CF.6060204@ens-lyon.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >>DRM/i915 does not work on my Dell Dimension 3000 (i865 chipset).
> >>It's the first -mm kernel I try on this box. I don't whether previous -mm
> >>worked or not. Anyway, 2.6.11 works great.
> >
> >

This is more than likely caused by the multi-bridge AGP stuff in -bk3
.. if you could test 2.6.11-bk2 and then -bk3 and see if it breaks
there.. if not there can you test the -bk6 -bk7 transition...

these are the only two points where DRM stuff was merged in .. I'm in
no position to test for about a week so unless someone else gets to it
first it'll be at least that long..

Dave.
