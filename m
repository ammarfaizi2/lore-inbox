Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbTAKPRA>; Sat, 11 Jan 2003 10:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbTAKPRA>; Sat, 11 Jan 2003 10:17:00 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:8940 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267227AbTAKPRA>; Sat, 11 Jan 2003 10:17:00 -0500
Date: Sat, 11 Jan 2003 16:25:29 +0100
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030111152529.GA20512@averell>
References: <20030110165441$1a8a@gated-at.bofh.it> <20030110165505$38d9@gated-at.bofh.it> <m3iswv27o3.fsf@averell.firstfloor.org> <1042295999.2517.10.camel@irongate.swansea.linux.org.uk> <20030111140602.GA20221@averell> <1042299059.2517.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042299059.2517.29.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 04:31:00PM +0100, Alan Cox wrote:
> > >   - ide-scsi needs some cleanup to fix switchover ide-cd/scsi
> > >     (We can't dump ide-scsi)
> > >   - Unregister path has races which cause all the long
> > >     standing problems with pcmcia and prevents pci unreg
> > 
> > Can't you just disable module unloading for the release ?
> 
> Only if I can also nail shut your PCMCIA slot, disallow SATA and remove
> some ioctls people use for docking.

Hmm? Didn't that all work in 2.4 with monolithic IDE ?

-Andi
