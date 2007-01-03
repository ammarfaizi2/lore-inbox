Return-Path: <linux-kernel-owner+w=401wt.eu-S1753302AbXACCAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbXACCAr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 21:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbXACCAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 21:00:46 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35956 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbXACCAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 21:00:46 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <459B0E2F.8050303@s5r6.in-berlin.de>
Date: Wed, 03 Jan 2007 03:00:15 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] the scheduled IEEE1394_OUI_DB removal
References: <20070102215653.GA20714@stusta.de>
In-Reply-To: <20070102215653.GA20714@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the scheduled IEEE1394_OUI_DB removal.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  Documentation/feature-removal-schedule.txt |    8 
>  drivers/ieee1394/Kconfig                   |   14 
>  drivers/ieee1394/Makefile                  |   10 
>  drivers/ieee1394/nodemgr.c                 |   39 
>  drivers/ieee1394/oui.db                    | 7048 ---------------------
>  drivers/ieee1394/oui2c.sh                  |   22 
>  6 files changed, 7141 deletions(-)

Thanks.

We can now also delete drivers/ieee1394/.gitignore. I'll do so when I
commit your patch, if nobody objects.
-- 
Stefan Richter
-=====-=-=== ---= ---==
http://arcgraph.de/sr/
