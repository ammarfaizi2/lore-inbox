Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbUKJTUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbUKJTUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbUKJTUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:20:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:61649 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262104AbUKJTTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:19:51 -0500
Subject: Re: IT8212 in 2.6.9-ac6 no raid 0 or raid 1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Toole <robert.toole@kuehne-nagel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4192308C.3060100@kuehne-nagel.com>
References: <418FE1B3.8020203@kuehne-nagel.com>
	 <1099956451.14146.4.camel@localhost.localdomain>
	 <4192308C.3060100@kuehne-nagel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100110612.20556.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 10 Nov 2004 18:16:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-10 at 15:15, Robert Toole wrote:
> I installed -ac7 yesterday, and have been testing for 24 hours now with 
> no problems. (It's way better than the scsi hack from ITE) There is just 
> one thing, the driver did not enable DMA by default, needless to say 
> performance was awful. I turned it on with hdparm and everything appears 
> ok. Is this by design due to the experimental nature of the driver?

Ah that is a bug. Please send me more info - drive info, hdparm etc.

> 
> I am testing by copying about 400 mb of files from one folder to another 
> on the raid array, over and over again. Is there a howto or test 
> software out there for better method to *really* hammer on the driver?

Just use it. Its been hammered a lot as part of my testing but the
moment other people just use it it breaks ;) 

