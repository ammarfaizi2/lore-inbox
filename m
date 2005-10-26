Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVJZVFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVJZVFL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 17:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVJZVFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 17:05:11 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:40337 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964900AbVJZVFK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 17:05:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RY6tlcyQ/JhKPekEYZpg3dKLaTwr9PJ3XkeGVcQ+sNV2+fxiOqk4HLirPw/SVFX/gLDBcdop1M3QXioEa8KjOXfbwsfBZ12vm93cSkgD94vfXcafjrIEHK+BDpcSiRnInkBefAk9Lz6PVvGPSrjUGFqjTl3pW/SSJDZnekVJtuM=
Message-ID: <21d7e9970510261405q976c185u7b74d130d42f611b@mail.gmail.com>
Date: Thu, 27 Oct 2005 07:05:09 +1000
From: Dave Airlie <airlied@gmail.com>
To: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: X unkillable in R state sometimes on startx , /proc/sysrq-trigger T output attached
Cc: alessandro.suardi@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <435FEF26.4050902@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <435FEF26.4050902@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>     BUG: fb_imageblit called before fb_check_var and fb_set_par function
>

> present in all recent kernels. It might be argued that this is not a
> kernel bug
> but a problem of  X - have a look at the Linux-fbdevel thread.
>
> Does X start reliably without a linux framebuffer driver?
> Does X start reliably with vesafb?

Hmm I missed the fact that you are using radeonfb, this could point to
the X chipset initialisation code as well...

I'll try and track down if the evil patch made it into xorg in FC4..

Dave.
