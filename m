Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKPWVW>; Thu, 16 Nov 2000 17:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129404AbQKPWVM>; Thu, 16 Nov 2000 17:21:12 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:57604 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129150AbQKPWUv>;
	Thu, 16 Nov 2000 17:20:51 -0500
Date: Thu, 16 Nov 2000 22:50:46 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] dmfe.c network driver update for 2.4
In-Reply-To: <3A130C6A.CDAD8AA2@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0011162241450.23936-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2000, Jeff Garzik wrote:

> Tobias Ringstrom wrote:
> > 
> > I have updated the dmfe.c network driver for 2.4.0-test by adding proper
> > locking (I hope), and also made transmission much efficient.
> > 
> > I would appreciate any feedback from people using this driver, to confirm
> > that I did not break it.
> > 
> > It would also be great if someone could take a look at the lock handling,
> > to confirm that is is correct and sufficient.
> 
> Would you mind creating a separate patch that -just- correcting the SMP
> safety?  That makes it much easier to review and apply, and then we can
> consider the other changes...

Such a patch will appear shortly. I and Frank Davis are currently merging
our patches for dmfe.c.

[Actually, I just added reasonable locks while my main goal was to improve
performance. I did not realize that there was such a strong need for SMP
safety (since it has been broken in that regard for a long time, without
anyone fixing it).]

/Tobias


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
