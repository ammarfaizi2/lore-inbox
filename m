Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWHHCTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWHHCTF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 22:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWHHCTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 22:19:05 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:45087 "EHLO
	asav02.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751210AbWHHCTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 22:19:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAMCQ10SBUg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: [PATCH] input: A few new KEY_xxx definitions
Date: Mon, 7 Aug 2006 22:19:02 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060808000925.GA6220@curacao>
In-Reply-To: <20060808000925.GA6220@curacao>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608072219.02315.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 20:09, Lennart Poettering wrote:
> From: Lennart Poettering <mzxreary@0pointer.de>
> 
> The attached patch adds four new KEY_xxx definitions to linux/input.h.
> 
> KEY_BLUETOOTH, KEY_WLAN:
> 
>     Some laptops have seperate "rfkill"
>     buttons for disabling/enabling Bluetooth and WLAN. 
> 
> KEY_POWERPLUG, KEY_POWERUNPLUG:
> 
>     Some laptops generate a fake key event when the power cord is
>     plugged or unplugged. (Notably MSI laptops, such as S270)
> 

How do these events get delivered? Are you saying that atkbd reports
key presses when pulling out AC cord?

-- 
Dmitry
