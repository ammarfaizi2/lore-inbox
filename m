Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131544AbQKCVMY>; Fri, 3 Nov 2000 16:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131405AbQKCVMO>; Fri, 3 Nov 2000 16:12:14 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15634 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131441AbQKCVMH>;
	Fri, 3 Nov 2000 16:12:07 -0500
Message-ID: <3A0329DA.38A90824@mandrakesoft.com>
Date: Fri, 03 Nov 2000 16:10:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@linux.com>
CC: Alan Cox <alan@redhat.org>, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <E13rj9s-0003c4-00@the-village.bc.nu> <3A032828.6B57611F@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> 
> Alan Cox wrote:
> 
> > > 10. To Do But Non Showstopper
> > >      * PCMCIA/Cardbus hangs (Basically unusable - Hinds pcmcia code is
> > >        reliable)
> > >           + PCMCIA crashes on unloading pci_socket
> >
> > The pci_socket crash is fixed it seems
> 
> Not unless it was fixed in test10 release.  I have a PC LinkSys dual 10/100 and
> 56K card that will kill the machine if you physically pull it out no matter what
> cardctl/module steps are taken.
> 
> It uses the ne2k and serial drivers.

Part of that might be that serial doesn't support hotplug without
patching.

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
