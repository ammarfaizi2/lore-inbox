Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274679AbRITWcb>; Thu, 20 Sep 2001 18:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274680AbRITWcW>; Thu, 20 Sep 2001 18:32:22 -0400
Received: from [209.202.108.240] ([209.202.108.240]:56588 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S274679AbRITWcN>; Thu, 20 Sep 2001 18:32:13 -0400
Date: Thu, 20 Sep 2001 18:32:22 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Lockup with 2.4.9-ac10 on Athlon
In-Reply-To: <200109202208.f8KM8o902962@deathstar.prodigy.com>
Message-ID: <Pine.LNX.4.33.0109201830590.26328-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, bill davidsen wrote:

> In article <Pine.LNX.4.33.0109100015360.22080-100000@terbidium.openservices.net> you write:
> | On Sun, 9 Sep 2001, Ignacio Vazquez-Abrams wrote:
> |
> | > On Sun, 9 Sep 2001, Ignacio Vazquez-Abrams wrote:
> | >
> | > I have solved the problem. It had to do with the setting of
> | > CONFIG_APM_REAL_MODE_POWER_OFF. It has to be on in my case.
> | >
> | > Is there any time when this option _has_ to be off?
> |
> | Sigh. I apologize. This did _not_ work. Does anyone else have any hoops for me
> | to jump through?
>
> Look for BIOS updates. I have a BP6 (dual Celeron) system, and I am
> really disappointed that the only way I can power it down under software
> control is to boot to another o/s. You may be able to get a BIOS which
> works.

Well, I've updated the BIOS from 1007 to 1008, so we'll see if that helps.
Somebody else has reported the same problem though, so we'll see.

> Note: if you have SMP and the kernel insists on disabling power off
> (like it's not thread safe or something?) you can use "lilo -R" to boot
> a uni kernel and then shut down.

Nope. UP here all the way.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

