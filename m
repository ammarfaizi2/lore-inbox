Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291972AbSBTQof>; Wed, 20 Feb 2002 11:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291988AbSBTQoZ>; Wed, 20 Feb 2002 11:44:25 -0500
Received: from www.transvirtual.com ([206.14.214.140]:51728 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291972AbSBTQoR>; Wed, 20 Feb 2002 11:44:17 -0500
Date: Wed, 20 Feb 2002 08:43:57 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Jean Paul Sartre <sartre@linuxbr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sis_malloc / sis_free
In-Reply-To: <Pine.LNX.4.40.0202192220550.13176-100000@sartre.linuxbr.com>
Message-ID: <Pine.LNX.4.10.10202200841290.5890-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	I would suggest 'duplicating' this code (yes, I *do* hate
> duplicating codes) or making that memory allocation code *really* shared
> between both modules (or we won't be able to successfully compile it,
> since the DRM code is on drivers/char/drm and the FB code is on
> drivers/video/sis/sis_main.c).

I agree it is strange to have the DRM code in drivers/char. It should be
in drivers/video. I guess in time. As for DRI and FB sharing code. You
will see this happen more and more in the future. Eventually I like to
merge both interfaces into one universal interface, but before I do that
the whole fbdev layer needs to be cleaned up which I'm doing now. 


