Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273072AbRIIVy2>; Sun, 9 Sep 2001 17:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273073AbRIIVyS>; Sun, 9 Sep 2001 17:54:18 -0400
Received: from gyre.weather.fi ([193.94.59.26]:58779 "EHLO gyre.weather.fi")
	by vger.kernel.org with ESMTP id <S273072AbRIIVyF>;
	Sun, 9 Sep 2001 17:54:05 -0400
Date: Mon, 10 Sep 2001 00:54:17 +0300 (EEST)
From: =?ISO-8859-1?Q?Jaakko_Hyv=E4tti?= <jaakko.hyvatti@iki.fi>
X-X-Sender: <jaakko@gyre.weather.fi>
To: Jussi Laako <jlaako@pp.htv.fi>
cc: Steven Spence <kwijibo@zianet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: AMD 760 (761?) AGP
In-Reply-To: <3B9A468F.66C20011@pp.htv.fi>
Message-ID: <Pine.LNX.4.33.0109100051370.31102-100000@gyre.weather.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Sep 2001, Jussi Laako wrote:
> Yes, I did try that and result is deadlock without video signal. Without AGP
> it works fine. XFree86 and dri/drm driver is the latest CVS version.
> (With or without dri enabled)

  For a workaround until it is fixed properly, find RADEON_SOFT_RESET_HDP
in your kernel radeon driver source and kill it.  Possibly XFree86 CVS
source is fixed already, but anyway you need to change and compile some
modules from XFree86 source too and install them to where the X server
will find them.

  Check out dri.sf.net -> project -> bug [ #221904 ] Radeon + AMD
Irongate.

-- 
Jaakko.Hyvatti@iki.fi         http://www.iki.fi/hyvatti/        +358 40 5011222
echo 'movl $36,%eax;int $128;movl $0,%ebx;movl $1,%eax;int $128'|as -o/bin/sync

