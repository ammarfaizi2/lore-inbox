Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbQLHSgy>; Fri, 8 Dec 2000 13:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132076AbQLHSgo>; Fri, 8 Dec 2000 13:36:44 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:44295 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130038AbQLHSg0>; Fri, 8 Dec 2000 13:36:26 -0500
Date: Fri, 8 Dec 2000 12:01:35 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Peter Samuelson <peter@cadcamlab.org>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTFS repair tools
Message-ID: <20001208120135.A4881@vger.timpanogas.org>
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org> <20001207221347.R6567@cadcamlab.org> <3A3066EC.3B657570@timpanogas.org> <20001208005337.A26577@alcove.wittsend.com> <20001207230407.S6567@cadcamlab.org> <3A306CE4.47B366B0@timpanogas.org> <14896.31327.179696.632616@wire.cadcamlab.org> <5.0.2.1.2.20001208072533.03fd97d0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <5.0.2.1.2.20001208072533.03fd97d0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Fri, Dec 08, 2000 at 07:37:55AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 07:37:55AM +0000, Anton Altaparmakov wrote:
> Hearing how many people trash their partition I would agree to comment out 
> the NTFS write option altogether. I will make a patch for both 2.4.0-testX 
> and 2.2.18latest and send them off to Linus/Alan over the weekend if no one 
> beats me to it.
> 
> Considering that people are blatantly ignoring all our warnings this might 
> be the Right Thing(TM) as it is easy enough to activate the option if 
> someone really wants/needs to use it. That should hopefully lower the 
> amount of incidents with people trashing their partitions[1][2].
> 
> Anton
> 
> [1] On the other hand it might not help much as people might just uncomment 
> it and go ahead using it, but there is a limit to how far we can go without 
> taking out the write part of the driver altogether! Which might actually 
> not be a Bad Thing(TM) were it not for the fact that having the write 
> support can actually help in fixing a trashed partition when people know 
> what they are doing...i.e. when they know what they can do safely and what 
> not. - It's saved me from loosing 10Gb+ of non-backed up data in the past!
> 
> [2] My NTFS repair utility is under development albeit very slowly which 
> should help a little bit once I have a stable release. - Initial release is 
> yet TBA as there are some very strange bugs in it at the moment, which 
> might actually turn out to be bugs in the compiler/libc/kernel as the 
> program runs fine sometimes and sometimes corrupts the partitions slightly, 
> operating on the _exact_ same partition with the _exact_ same data on it! - 
> Anyway, I am not releasing this to the public before I have figured out WTH 
> is going on...


Anton,

I will be able to help "officially" in another 14 months, when the 
inevitability window is closed.  Unfortunately, by then, MS will 
have altered the on-disk structures again, makeing the job even harder.
You and Alan should Brainstorm a solution.  Removing write support or 
putting in a disclaimer would suffice.  It's your call, BTW along 
with Alan.

:-)

Jeff

> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
