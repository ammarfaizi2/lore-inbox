Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272288AbRIEThP>; Wed, 5 Sep 2001 15:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272289AbRIEThH>; Wed, 5 Sep 2001 15:37:07 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:21257 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S272288AbRIETgq>; Wed, 5 Sep 2001 15:36:46 -0400
Message-ID: <3B967EDD.5A81F2DD@delusion.de>
Date: Wed, 05 Sep 2001 21:37:01 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB device not accepting new address
In-Reply-To: <mailman.999666181.21742.linux-kernel2news@redhat.com> <200109051619.f85GJEo07592@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> > I have just come across another USB address problem, which happens
> > sporadically and is not easy to reproduce.
> 
> >   1: [cfefa240] link (00000001) e0 IOC Stalled CRC/Timeo Length=7ff MaxLen=7ff
> >   DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
> 
> If usb_set_address() ends in timeouts, something is bad with the
> hadrware, most likely. Microcode crash in the device, perhaps.
> Someone, I think it was Oliver, posted a patch that retries
> usb_set_address(). It may help you, look in linux-usb-devel
> archives.

Maybe it's a hardware problem, but this problem has never occured before Alan
started merging bits of 2.4.9 into his tree.

-Udo.
