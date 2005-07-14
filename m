Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVGNRLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVGNRLp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVGNRLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:11:44 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:34923 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261564AbVGNRLX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:11:23 -0400
Date: Thu, 14 Jul 2005 18:53:25 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: moving DRM header files
Message-ID: <20050714185325.GA8791@mars.ravnborg.org>
References: <21d7e99705071321044c216db4@mail.gmail.com> <9e4733910507132125af9835@mail.gmail.com> <21d7e9970507132209e7ac477@mail.gmail.com> <9e47339105071406177dc4dad6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105071406177dc4dad6@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> When you start merging DRM and fbdev you will be able to use relative
> paths that are closer together.  For example #include
> "../char/drm/drmP.h" versus "#include "drm/drmP.h" for internal
> headers.

No. Using relative include paths is not good. I will most probarly
not work with make O=.

	Sam
