Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQKOWwZ>; Wed, 15 Nov 2000 17:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129316AbQKOWwQ>; Wed, 15 Nov 2000 17:52:16 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35333 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129348AbQKOWwJ>;
	Wed, 15 Nov 2000 17:52:09 -0500
Message-ID: <3A130C6A.CDAD8AA2@mandrakesoft.com>
Date: Wed, 15 Nov 2000 17:21:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@tellus.mine.nu>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] dmfe.c network driver update for 2.4
In-Reply-To: <Pine.LNX.4.21.0011152118540.22362-100000@svea.tellus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Ringstrom wrote:
> 
> I have updated the dmfe.c network driver for 2.4.0-test by adding proper
> locking (I hope), and also made transmission much efficient.
> 
> I would appreciate any feedback from people using this driver, to confirm
> that I did not break it.
> 
> It would also be great if someone could take a look at the lock handling,
> to confirm that is is correct and sufficient.

Would you mind creating a separate patch that -just- correcting the SMP
safety?  That makes it much easier to review and apply, and then we can
consider the other changes...

Thanks,

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
