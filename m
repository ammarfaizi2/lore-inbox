Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287616AbSBGMf1>; Thu, 7 Feb 2002 07:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287632AbSBGMfT>; Thu, 7 Feb 2002 07:35:19 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:36481 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S287616AbSBGMfD>;
	Thu, 7 Feb 2002 07:35:03 -0500
Date: Thu, 7 Feb 2002 13:35:01 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200202071235.NAA23592@harpo.it.uu.se>
To: axboe@suse.de
Subject: Re: [PATCH] make ide-dma compile in 2.5.4-pre2, woops
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002 09:45:12 +0100, Jens Axboe wrote:
>A minor slip up on my behalf broke ide-dma compile in 2.5.4-pre2 due to
>the scatterlist ->address removal. This patch should make it work again,

ide-dma, ide-scsi, and sg compile and work fine for me in 2.5.4-pre2.
It seems the ->address removal is only in your tree, not Linus'.

/Mikael
