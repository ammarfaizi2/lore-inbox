Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVHQMdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVHQMdv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 08:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVHQMdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 08:33:51 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:60827 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751112AbVHQMdu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 08:33:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IAEY5F7TScnRdBHAr03xaG2/fujp3kfsXz8N+D+RoDihcIP/WWYz23/NP2jEN0E2F6PtSxSPsu1Y6PTPU+Ke/LkgKkpil93oS9leFrCH8FO0FXBzbN+anRYYZT1HgTz61L1pvj+x6VbSEozxoikgFnTSx0j9ooWSz6MgQ3r9Y18=
Message-ID: <21d7e9970508170533acfd8d@mail.gmail.com>
Date: Wed, 17 Aug 2005 22:33:46 +1000
From: Dave Airlie <airlied@gmail.com>
To: Ed Tomlinson <tomlins@cam.org>
Subject: Re: 2.6.13-rc3-mm2/mm1 breaks DRI
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <21d7e997050729210379e221c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050727024330.78ee32c2.akpm@osdl.org>
	 <200507282037.52292.tomlins@cam.org>
	 <21d7e9970507281741fb51c98@mail.gmail.com>
	 <200507290652.44418.tomlins@cam.org>
	 <21d7e997050729210379e221c3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The most important question is if mainline 2.6.13-rc3 or -rc4 is okay?
> 
> If so then it is the -mm only that breaks  it, if -mm only can you
> 
> modprobe drm debug=1
> modprobe radeon
> 

Okay I've had time to think about this a bit...

It looks like the 32/64-bit changes might be affecting pure 64-bit..

Thre output of the drm debug=1 and radeon then start X on
2.6.13-rc5-mm1 would really help me out..

Thanks.
Dave.
