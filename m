Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbVGNFJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbVGNFJG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 01:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbVGNFJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 01:09:06 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:51043 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262906AbVGNFJE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 01:09:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZDkhlOpbF90i2JWpn1InTu9pk+i37FEFJuZuJBB0nFTZPWjtqRbjOLMl2LDXb4wctdlVSEvWksxuJvkGEEgAELlHtHI6PZpYtBBTXKu3yk7VVJr5Q2YCscC/Q0yivTCyfaytCpco9Xqi3ttJ0OOghPKW31DaC4kHhJoclSUt0AU=
Message-ID: <21d7e9970507132209e7ac477@mail.gmail.com>
Date: Thu, 14 Jul 2005 15:09:03 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: moving DRM header files
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910507132125af9835@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <21d7e99705071321044c216db4@mail.gmail.com>
	 <9e4733910507132125af9835@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm thinking include/linux/drm/
> > but include/linux would also be possible.
> >
> > Any suggestions or ideas?
> 
> If you're in a mood to move things, how about moving drivers/char/drm
> to drivers/video/drm.

But that has little point beyond aesthetics... moving the header files
is for a reason that I want them to start appearing in userspace
includeable places.. as part of the cleanup for libdrm..

Moving c files internally in the kernel provides no real benefit over
not moving them..

Dave.
