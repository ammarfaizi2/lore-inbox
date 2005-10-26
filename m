Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVJZKZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVJZKZP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 06:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbVJZKZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 06:25:15 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:23097 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751339AbVJZKZN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 06:25:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B4BjtRSsL4Ddx+jBjZ2jUVzkco0D9KB7SesKZCWfZnUDj8IyYBHzbJ4FVLqe107Ft/nAqv07OSoQuQpsayc2d3ex9l+Tr0OWWjJZj/e2xxHUgFvdT8fvqqEBBlAd/caRAG7zNPf5whLyEdiJN/LOMeG+BE1BSixNqB8+c7JZePw=
Message-ID: <21d7e9970510260325o2a47e6f5gc64d29eec42de086@mail.gmail.com>
Date: Wed, 26 Oct 2005 20:25:12 +1000
From: Dave Airlie <airlied@gmail.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Subject: Re: X unkillable in R state sometimes on startx , /proc/sysrq-trigger T output attached
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0510251335ke8e7ae6n883e0b44a9920ce4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0510251335ke8e7ae6n883e0b44a9920ce4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If anyone has an idea on what to do to try and reproduce
>  and/or debug further, that'd be cool.
>
> Box is a Dell Latitude C640 laptop, PIV@1.8Ghz,
>  1GB RAM, with a USR2210 802.11b wireless
>  PC Card; video card is a Radeon 7500 M7 LW.
>

Your getting an X hang which is usually a DRM/AGP or X configuartion problems..

Please send me your /etc/X11/xorg.conf and /var/log/Xorg.0.log after a hang..

did it work with any kernel before? and suddenly break recently?

Dave.
