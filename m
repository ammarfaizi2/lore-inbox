Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129772AbQKQXBh>; Fri, 17 Nov 2000 18:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbQKQXB1>; Fri, 17 Nov 2000 18:01:27 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:10511 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129431AbQKQXBN>;
	Fri, 17 Nov 2000 18:01:13 -0500
Message-ID: <3A15B18A.1A46EB02@mandrakesoft.com>
Date: Fri, 17 Nov 2000 17:30:34 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Davis <fdavis@andrew.cmu.edu>
CC: Tobias Ringstrom <tori@tellus.mine.nu>, linux-kernel@vger.kernel.org
Subject: Re: [CFT] dmfe.c network driver update for 2.4
In-Reply-To: <3819508582.974482117@primetime2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --On Friday, November 17, 2000 10:20 AM +0100 Tobias Ringstrom
> > How about adding an ifdef CONFIG_SMP then print ugly warning to all known
> > SMP unsafe drivers? A message could be printed booth at compile and load
> > time.

Frank Davis wrote:
>         I would rather fix those non-SMP compliant drivers to be SMP compliant,
> then keeping them 'broken'. Adding the print statements would only be a
> temporary solution.


Agreed.  If people have SMP safety patches for net drivers, let me
know...

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
