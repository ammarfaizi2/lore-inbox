Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293007AbSBVVm5>; Fri, 22 Feb 2002 16:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293009AbSBVVms>; Fri, 22 Feb 2002 16:42:48 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:29195 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S293007AbSBVVmd>; Fri, 22 Feb 2002 16:42:33 -0500
Date: Fri, 22 Feb 2002 22:40:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, G?rard Roudier <groudier@free.fr>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222224007.C7238@suse.cz>
In-Reply-To: <3C76A053.55A32E77@mandrakesoft.com> <Pine.LNX.4.10.10202221143290.2519-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202221143290.2519-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Fri, Feb 22, 2002 at 11:46:46AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 11:46:46AM -0800, Andre Hedrick wrote:

> > > Average user does not care about PCI probing. But it does care on booting
> > > the expected kernel image and mounting the expected partitions.
> > > It also doesn't care of code aesthetical issue even with free software
> > > since average user is not a kernel hacker.
> > 
> > Most SCSI drivers are not using the 2.4 PCI API, which has been
> > documented and stable for a while now.
> 
> Also not that ATA/IDE drivers were not using 2.4 PCI API and likewise was
> stable for a while.

But that's a shame on the ATA/IDE drivers actually.

> > This is need for transparented support for cardbus and hotplug PCI, not
> 
> This is HOST level operation not DEVICE, and you do not see the differenc.

Exactly. That's why it is needed for hotplug PCI and CardBus.

> > some pie-in-the-sky code asthetic.  This will become further important
> > as 2.5.x transitions more and more to Mochel's driver model work, which
> > will among other things provide a sane power management model.
> > 
> > To tangent, IDE and SCSI hotplug issues are interesting, because a lot
> > of people forget or mix up the two types of hotplug, board (host)
> > hotplug and drive hotplug.
> 
> It is a shame that I will now have to start from scratch to create another
> API for hotplug device for ATA/ATAPI that was migrating into SCSI because
> of the ide-scsi driver.

Hmm?

-- 
Vojtech Pavlik
SuSE Labs
