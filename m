Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267941AbTAKSXw>; Sat, 11 Jan 2003 13:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267942AbTAKSXw>; Sat, 11 Jan 2003 13:23:52 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62868
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267941AbTAKSXu>; Sat, 11 Jan 2003 13:23:50 -0500
Subject: Re: any chance of 2.6.0-test*?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030111152529.GA20512@averell>
References: <20030110165441$1a8a@gated-at.bofh.it>
	 <20030110165505$38d9@gated-at.bofh.it>
	 <m3iswv27o3.fsf@averell.firstfloor.org>
	 <1042295999.2517.10.camel@irongate.swansea.linux.org.uk>
	 <20030111140602.GA20221@averell>
	 <1042299059.2517.29.camel@irongate.swansea.linux.org.uk>
	 <20030111152529.GA20512@averell>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042312710.2952.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 11 Jan 2003 19:18:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 15:25, Andi Kleen wrote:
> On Sat, Jan 11, 2003 at 04:31:00PM +0100, Alan Cox wrote:
> > > >   - ide-scsi needs some cleanup to fix switchover ide-cd/scsi
> > > >     (We can't dump ide-scsi)
> > > >   - Unregister path has races which cause all the long
> > > >     standing problems with pcmcia and prevents pci unreg
> > > 
> > > Can't you just disable module unloading for the release ?
> > 
> > Only if I can also nail shut your PCMCIA slot, disallow SATA and remove
> > some ioctls people use for docking.
> 
> Hmm? Didn't that all work in 2.4 with monolithic IDE ?

The pcmcia stuff crashes erratically with the old IDE the bugs have not
changed but the problem now shows up far more often. With a 2Gb type II
PCMCIA IDE disk I get a crash about 1 in 3 ejects now.

