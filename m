Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312923AbSDERpT>; Fri, 5 Apr 2002 12:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312986AbSDERpJ>; Fri, 5 Apr 2002 12:45:09 -0500
Received: from www.transvirtual.com ([206.14.214.140]:1809 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S312923AbSDERow>; Fri, 5 Apr 2002 12:44:52 -0500
Date: Fri, 5 Apr 2002 09:44:39 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Sebastian Droege <sebastian.droege@gmx.de>
cc: Brett Nuske <bnuske@cs.rmit.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: COMPILE BUG: SiS DRM Support
In-Reply-To: <20020405143410.0cfc2c2c.sebastian.droege@gmx.de>
Message-ID: <Pine.LNX.4.10.10204050943000.21397-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Is there any obvious reasons why this isn't compiling?
> Try compiling with SiS framebuffer device (CONFIG_FB_SIS and 
> CONFIG_FB_SIS_300 or CONFIG_FB_SIS_315) activated... the SiS DRI driver
> needs it... don't ask me why ;)

Because they share common code. It is actually better that they work
together since this way they will not step on each others toes. Someday I
plan to merge both the fbdev and drm interfaces together.


