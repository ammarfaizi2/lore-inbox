Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVACIhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVACIhh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 03:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVACIhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 03:37:37 -0500
Received: from mproxy.gmail.com ([216.239.56.245]:32533 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261393AbVACIhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 03:37:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=fGBC30JY+nHcctyK8CUyWoAkL5qOzZYXGBjb+Ht8nfYplA6nozAYCxUiulObTguhTps3bZOZPb9y5qQ2v0eIEqWDGKpKOWzRJquO1Qeud6y8qc02dZMeBeUUUlA88UY7z16fGWaJACUB2LEauvPgXRfWqg7kIpdIsBT1Xv1u+38=
Message-ID: <21d7e997050103003720c43931@mail.gmail.com>
Date: Mon, 3 Jan 2005 19:37:32 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Mark Hindley <mark@hindley.uklinux.net>
Subject: Re: 2.6.{9,10}: VIA DRM undefined symbols
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050103035105.GA7231@hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050103035105.GA7231@hindley.uklinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Looking back, this seems to have appeared in 2.6.9 with the introduction
> of the capabilities bitmask. The via driver appears not to have been
> converted.
> 
> I am still trying to understand the new structure. What else does the
> missing viadrv_driver_register_fns need to set apart from
> dev->driver_features?

what via driver is this? where does it come from, the kernel doesn't
ship with via drivers yet... the DRM has been completely redesigned so
old modules won't work anymore...

Dave.
