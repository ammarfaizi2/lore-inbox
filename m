Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129178AbRAaVgq>; Wed, 31 Jan 2001 16:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129158AbRAaVgg>; Wed, 31 Jan 2001 16:36:36 -0500
Received: from cmb1-3.dial-up.arnes.si ([194.249.32.3]:13188 "EHLO
	cmb1-3.dial-up.arnes.si") by vger.kernel.org with ESMTP
	id <S129026AbRAaVgW>; Wed, 31 Jan 2001 16:36:22 -0500
From: Igor Mozetic <igor.mozetic@uni-mb.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14968.33568.482353.888533@cmb1-3.dial-up.arnes.si>
Date: Wed, 31 Jan 2001 22:26:56 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: possible bug with adaptec aic-7896 and 2.4.x
X-Mailer: VM 6.89 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Prins writes:
> in 2.4.0 and 2.4.1 on a pentium 3 with an onboard adaptec AIC-7896, i 
> receive the following after it is detected:
> 
> scsi: aborting command due to timeout: pid 0, scsi0, channel 0, id 0
> lun 0 Inquiry 00 00 00 ff 00

I my case machine doesn't even boot.
You might try the aic7xxx driver at:
http://people.FreeBSD.org/~gibbs/linux/

I tried the 6.0.9BETA version and machine at least booted,
but crashed in a couple of days. So I'm back to 2.2.18 :(

-Igor Mozetic
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
