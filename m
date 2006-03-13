Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWCMURr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWCMURr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWCMURr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:17:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:28902 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932426AbWCMURp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:17:45 -0500
Date: Mon, 13 Mar 2006 21:17:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Paul Blazejowski <paulb@blazebox.homeip.net>
cc: Lee Revell <rlrevell@joe-job.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Linux v2.6.16-rc6
In-Reply-To: <1142202089.9934.13.camel@blaze.homeip.net>
Message-ID: <Pine.LNX.4.61.0603132115540.7510@yvahk01.tjqt.qr>
References: <1142189154.21274.20.camel@blaze.homeip.net> 
 <1142199970.25358.173.camel@mindpipe> <1142202089.9934.13.camel@blaze.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I belive the modes should say DMA100 because UDMA133 would be mode ATA-7
>and DMA100 ATA-6 mode. This is the info i get from hdparm -I on the ata3
>drive: DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
>

  UDMA4 = 66
  UDMA5 = 100
  UDMA6 = 133

Has afaics nothing to do with "ATA-5" or -6 or -7 as reported by smartctl 
"ATA version".


Jan Engelhardt
-- 
