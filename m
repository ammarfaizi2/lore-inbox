Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbVKPOue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbVKPOue (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbVKPOue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:50:34 -0500
Received: from [195.144.244.147] ([195.144.244.147]:21381 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S1030356AbVKPOud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:50:33 -0500
Message-ID: <437B4734.7060306@varma-el.com>
Date: Wed, 16 Nov 2005 17:50:28 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org> <437A57CB.8090302@varma-el.com> <20051116031520.GL5546@mag.az.mvista.com>
In-Reply-To: <20051116031520.GL5546@mag.az.mvista.com>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=pgp.dtype.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mark A. Greer wrote:

> When I originally submitted the m41t00 patch, I made it clear that it
> was PPC only and gave the reason why:
> 
> http://archives.andrew.net.au/lm-sensors/msg29280.html
> 
> What processor arch did you test your m41t85 driver on?
PPC32 :) (MPC5200).

> AFAICT, PPC is the only arch that uses that exact definition of
> get/set_rtc_time().
But chip (and driver) itself may be used in any i2c net with any
chip as master with slightly modification of platform driver.
Am I right?.

-- 
Regards
Andrey Volkov
