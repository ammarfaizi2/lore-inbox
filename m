Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRA0KwK>; Sat, 27 Jan 2001 05:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131370AbRA0KwA>; Sat, 27 Jan 2001 05:52:00 -0500
Received: from [194.213.32.137] ([194.213.32.137]:29188 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131418AbRA0Kvy>;
	Sat, 27 Jan 2001 05:51:54 -0500
Message-ID: <20010126183816.A260@bug.ucw.cz>
Date: Fri, 26 Jan 2001 18:38:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: Timur Tabi <ttabi@interactivesi.com>, linux-kernel@vger.kernel.org
Subject: Re: NTFS safety and lack thereof - Was: Re: Linux 2.4.0ac11
In-Reply-To: <E14LOAm-0006z0-00@the-village.bc.nu> <E14LOAm-0006z0-00@the-village.bc.nu> <01012416081105.19999@nessie> <5.0.2.1.2.20010124162842.00a48720@pop.cus.cam.ac.uk> <20010124170337Z129710-18594+930@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010124170337Z129710-18594+930@vger.kernel.org>; from Timur Tabi on Wed, Jan 24, 2001 at 11:03:30AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >Is read access safe ?
> > 
> > Of course read-only is safe. As long as you mount the partition READ-ONLY 
> > nothing can happen to it in any way, your NTFS data is at least safe.
> 
> Isn't it still theoretcially possible for the driver to send commands to the
> disk controller that cause data to become overwritten, even when it's just
> supposed to read that data?

AFAICS, ext3 is happy to write to read-only mounted partition. So
question was not completely stupid.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
