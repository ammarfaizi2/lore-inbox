Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284755AbRLUQoJ>; Fri, 21 Dec 2001 11:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284746AbRLUQn7>; Fri, 21 Dec 2001 11:43:59 -0500
Received: from olinz-dsl-1316.utaonline.at ([212.152.239.38]:50414 "EHLO
	falke.mail") by vger.kernel.org with ESMTP id <S284755AbRLUQnv>;
	Fri, 21 Dec 2001 11:43:51 -0500
Message-ID: <3C2363F8.28E338CE@falke.mail>
Date: Fri, 21 Dec 2001 17:31:52 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Thomas Winischhofer <tw@webit.com>, linux-kernel@vger.kernel.org
Subject: Re: @Linus, Marcello, (Alan?) (regards sisfb)
In-Reply-To: <E16HRwE-0000X8-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 10.0.0.13
X-Return-Path: tw@webit.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > So, the whole theory with this driver is a failure.
> 
> Its the same driver core XFree86 uses.  Also if you are not looking at a
> currentish 2.4 or 2.5 you'll have the wrong code.

No, it's not the same driver core. Take a look yourself.

I used the 2.4.16 code as basis. There have not been any patches since
that (at least in the 2.4 series).

I am currently also re-writing the X driver using the new core (and
eventually VESA functions). 

> > Are you willing to include the new driver in the kernel?
> > It's available here: http://members.aon.at/~twinisch/sisfb.tar.gz
> 
> If your timings are wrong you may destroy the LCD panel.

The timings are taken from the machine's BIOS. If that data is wrong, no
driver will ever work.

By the way: You might also have destroyed your LCD when using the old
drivers with the 0-values.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria                  Check it out:
mailto:tw@webit.com              http://www.webit.com/tw

