Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWCPPrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWCPPrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbWCPPrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:47:40 -0500
Received: from kirby.webscope.com ([204.141.84.57]:14720 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1750848AbWCPPrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:47:40 -0500
Message-ID: <441987F5.2020001@linuxtv.org>
Date: Thu, 16 Mar 2006 10:44:53 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] VIDEO_CPIA2 must depend on USB
References: <20060316132727.GF3914@stusta.de>
In-Reply-To: <20060316132727.GF3914@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> CONFIG_VIDEO_CPIA2=y, CONFIG_USB=n results in the following compile 
> error:
> <--  snip  -->
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>   
Adrian-

I've moved the CPIA2 build configuration to cpia2/Kconfig in the v4l-dvb 
mercurial tree, so I had to alter your patch slightly in order to apply it.

You can see the regenerated patch at:

http://linuxtv.org/hg/~mkrufky/v4l-dvb?cmd=changeset;node=bdb45ee555aa

Thank you!

Mauro, I have some other build configuration fixes that I haven't 
applied to the tree yet, but the following have already been applied and 
tested.  (using 'make kernel-links')  Please pull at your convenience:

http://linuxtv.org/hg/~mkrufky/v4l-dvb

-VIDEO_CPIA2 must depend on USB
-Kconfig: fix VIDEO_PVRUSB2 video decoder build configuration
-Kconfig: remove VIDEO_DECODER
-Kconfig: add menu items for saa7115 decoder and saa7127 encoder modules

Regards,

Michael Krufky


