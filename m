Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292194AbSBTS7G>; Wed, 20 Feb 2002 13:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292211AbSBTS67>; Wed, 20 Feb 2002 13:58:59 -0500
Received: from [62.47.19.142] ([62.47.19.142]:7297 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S292194AbSBTS6q>;
	Wed, 20 Feb 2002 13:58:46 -0500
Message-ID: <3C73EEC8.EF99F953@webit.com>
Date: Wed, 20 Feb 2002 19:45:28 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: walt <wsheets@sbcglobal.net>
Subject: Re: [2.2.18-rc1] sis.o missing symbol errors (still)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


walt wrote:
> In order to avoid missing-symbol errors for drm/sis.o
> *all* of the following options must be set, even though
> the specified SiS chips are not being used: 
>
> CONFIG_FB=y
> CONFIG_FB_SIS=y/m
> CONFIG_FB_SIS_300=y
> CONFIG_FB_SIS_315=y

I have a 630 and sisfb and sis (drm) compile well *without* 315... Just
remember to insmod sisfb.o BEFORE sis.o.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:tw@webit.com                  *** http://www.webit.com/tw
