Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVGZPwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVGZPwH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVGZPtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:49:31 -0400
Received: from mail.dvmed.net ([216.237.124.58]:45497 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261860AbVGZPsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:48:19 -0400
Message-ID: <42E65B34.9080700@pobox.com>
Date: Tue, 26 Jul 2005 11:48:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <20050726150837.GT3160@stusta.de>
In-Reply-To: <20050726150837.GT3160@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch schedules obsolete OSS drivers (with ALSA drivers that 
> support the same hardware) for removal.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> I've Cc'ed the people listed in MAINTAINERS as being responsible for one 
> or more of these drivers, and I've also Cc'ed the ALSA people.
> 
> Please tell if any my driver selections is wrong.
> 
>  Documentation/feature-removal-schedule.txt |    7 +
>  sound/oss/Kconfig                          |   79 ++++++++++++---------
>  2 files changed, 54 insertions(+), 32 deletions(-)

Please CHECK before doing this.

ACK for via82cxxx.

NAK for i810_audio:  ALSA doesn't have all the PCI IDs (which must be 
verified -- you cannot just add the PCI IDs for some hardware)

	Jeff



