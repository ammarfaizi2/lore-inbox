Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVEBXQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVEBXQf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 19:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVEBXQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 19:16:35 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:57491 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261211AbVEBXQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 19:16:33 -0400
Date: Tue, 3 May 2005 01:15:27 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: skystar@moldova.cc, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, kraxel@bytesex.org,
       linux-kernel@vger.kernel.org
Message-ID: <20050502231527.GA11667@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Adrian Bunk <bunk@stusta.de>, skystar@moldova.cc,
	linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
	kraxel@bytesex.org, linux-kernel@vger.kernel.org
References: <20050502014708.GZ3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502014708.GZ3592@stusta.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 217.86.176.198
Subject: Re: [2.6 patch] drivers/media/dvb/b2c2/skystar2.c: remove an impossible code path
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 03:47:08AM +0200, Adrian Bunk wrote:
> This patch removes an impossible code path found by the Coverity 
> checker (look at the assignement in the first line of the context).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 10 Apr 2005
> 
>  drivers/media/dvb/b2c2/skystar2.c |    2 +-

I'm sorry that your patch got ignored the first time.

The patch is OK, but the skystar2 driver has been superseeded
by the flexcop-pci driver in linuxtv.org CVS.


Thanks,
Johannes
