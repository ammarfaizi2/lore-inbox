Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272061AbRIJW3n>; Mon, 10 Sep 2001 18:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272072AbRIJW3e>; Mon, 10 Sep 2001 18:29:34 -0400
Received: from hermes.domdv.de ([193.102.202.1]:27410 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S272061AbRIJW32>;
	Mon, 10 Sep 2001 18:29:28 -0400
Message-ID: <XFMail.20010911002924.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3B9D1078.54860A60@t-online.de>
Date: Tue, 11 Sep 2001 00:29:24 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: <SPATZ1@t-online.de (Frank Schneider)>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors)
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Something other made me wonder:
> I ran the machine several times with the *new* aic7xxx-driver (TCQ=32)
> and the "aic7xxx=verbose" commandline, and i noticed the following:
> At every reboot (made by "reboot", RH7.1), the machine was not able to
> stop the raid5 correctly...it un-mounted the mountpoint (/home) and then
> it normaly wants to stop the raid...(you see the messages "mdrecoveryd
> got waken up...") but that did not work and after some time (30sec) the
> kernel Ooopsed. This was reproducable and only occured if booted with
> the "aic7xxx=verbose" kernel-parameter.
> The effect after reboot was, that the raid had to be resynced because
> one partition (that which always falls out) was damaged or at least
> seemed to.
> (The filesystem was clean, that was already unmounted as the oops
> occured.)
> 
> Perhaps someone can test if this is reproducable with his machine
> too...i use kernel 2.4.3, raid is built-in, also the aic7xxx, there are
> three raid-disks (LVD, aic7xxx-controller on Mobo) in a raid5 mounted as
> /home.
> 
Same behaviour for RAID1 and the new aic7xxx driver for me at nearly every
reboot. The old driver works just fine (2.4.9).


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
