Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280431AbRJaTPh>; Wed, 31 Oct 2001 14:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280434AbRJaTP2>; Wed, 31 Oct 2001 14:15:28 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:15492 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S280431AbRJaTPQ>;
	Wed, 31 Oct 2001 14:15:16 -0500
Message-ID: <3BE04DE8.F012C592@pobox.com>
Date: Wed, 31 Oct 2001 11:15:52 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: safemode <safemode@speakeasy.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6 + preempt dri lockup
In-Reply-To: <20011031152822Z280263-17408+8294@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

safemode wrote:

> Using 2.4.14-pre6 and Love's preempt patch, i recompiled my X's matrox drm
> driver and loaded it.  All seemed well and good and i started X and it locked
> up.  I had to reboot.  Upon rebooting I started X without loading the drm
> module and disabling DRI and it loaded fine.  Tis not good.   The drm module
> worked in every kernel prior to this one with and without the preempt patch.
> I couldn't get an error message or anything but i did hear my monitor resync,
> it just never displayed any kind of image.  The entire system was
> unresponsive.

Just a data point -

Running 2.4.14-pre6 + preempt + a.m.  low latency
Hardware = PIII-933 on intel mobo, 512 MB
Video = voodoo3 agp

I gave DRI a workout with several hours of
wolfenstein network demo, then ran 40 min or
so of dbench and then let normal services run
through the night. The system remains smooth
and responsive, no incidents in syslog.

So there may be specific driver bugs which
are being invoked in your situation.

cu

jjs


