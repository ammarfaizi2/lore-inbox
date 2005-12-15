Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVLOQI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVLOQI4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVLOQI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:08:56 -0500
Received: from [85.8.13.51] ([85.8.13.51]:1460 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750744AbVLOQIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:08:55 -0500
Message-ID: <43A19517.8030206@drzeus.cx>
Date: Thu, 15 Dec 2005 17:08:55 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: wbsd-devel@list.drzeus.cx, linux-kernel@vger.kernel.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 1/3] wbsd: convert to the new platfrom device interface
References: <20051215053933.125918000.dtor_core@ameritech.net> <20051215054444.590158000.dtor_core@ameritech.net>
In-Reply-To: <20051215054444.590158000.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> wbsd: convert to the new platfrom device interface
>
> platform_device_register_simple() is going away, switch to
> using platfrom_device_alloc() + platform_device_add(). Also
> make sure that wbsd_driver gets unregistered when wbsd_init
> fails.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
>   

Acked-by: Pierre Ossman <drzeus@drzeus.cx>

