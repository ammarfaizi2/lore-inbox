Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279945AbRJ3MRY>; Tue, 30 Oct 2001 07:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279941AbRJ3MRF>; Tue, 30 Oct 2001 07:17:05 -0500
Received: from alpham.uni-mb.si ([164.8.1.101]:27152 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S279942AbRJ3MQ6>;
	Tue, 30 Oct 2001 07:16:58 -0500
Date: Tue, 30 Oct 2001 12:35:11 +0100
From: Igor Mozetic <igor.mozetic@uni-mb.si>
Subject: Re: SMP machine with 2GB ram hangs without any clue
To: WvanBommel@jasongeo.com, linux-kernel@vger.kernel.org
Message-id: <3BDE906F.2C3B54DE@uni-mb.si>
Organization: CAMTP
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2x 1Ghz PIII fitted on a serverworks chipset, and 2GB ram.
> Video Card is an Geforce MX-400 twinview setup (no agp, several Geforce cards tried)
> Network is an intergrated intel ether express (eepro100 driver)
>
> None of the combinations would give a stable system (that is hanging the kernel afther 1/2 - 60 minutes)
> The system would crash so badly that even ping responsed stayed out. (No numlock either)

I have a similar problem - see recent thread "Any stable 2.4 kernel?"
I received some useful suggestions:
1) For real stability, consider using 2.2
2) I'm better off then you since my machine stays up for days/weeks.
I had the best luck with 2.4.3 so far (weeks of uptime).
However, when it locks up not even power-off button works.
I have to unplug the power.
3) Default eepro100 driver can be problematic, and some comercial 
distros use Intel's driver. I don't know if it can cause such hard 
lockups (anybody comment, please?) but it seems like the next candidate
to consider (after mboard and highmem).

-Igor Mozetic
