Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUDQMQI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 08:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUDQMQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 08:16:08 -0400
Received: from mail.gmx.de ([213.165.64.20]:9614 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262862AbUDQMQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 08:16:03 -0400
X-Authenticated: #1226656
Date: Sat, 17 Apr 2004 14:15:37 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: Willy Tarreau <w@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux on UltraSparcII E450
Message-Id: <20040417141537.2986af5a@vaio.gigerstyle.ch>
In-Reply-To: <20040417100630.GG596@alpha.home.local>
References: <20040417105303.7936e413@vaio.gigerstyle.ch>
	<20040417100630.GG596@alpha.home.local>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2004 12:06:30 +0200
Willy Tarreau <w@w.ods.org> wrote:

> Hmmm, I believe you forgot to tell which kernel version you used, and
> how you configured it :-)
> 
> Willy

Oh f**k:-) Sorry for that.

It is 2.4.26.

Sorry, I can't attach the .config because I'm not near the machine...

RAID1 + RAID5 code in kernel.
No preempt but SMP.
ext3 fs on all disks.
Most other code as modules configured.

Hopefully nothing forgotten this time.

Thank you!

Regards

Marc

> 
> On Sat, Apr 17, 2004 at 10:53:03AM +0200, Marc Giger wrote:
> > Hi All,
> > 
> > Last week I had the honor to install Linux on a E450 with 2 cpu's.
> > All went fine at first. Long compiling sessions were no problem for
> > the machine. Later we installed 16 additional SCSI disks and we
> > built 4 x Soft-RAID5 groups with 4 disks each.
> > After some time during the sync processes the machine stops
> > responding. Simply dead. The same thing happens after every boot
> > when the sync process is in action.
> > 
> > My question now is: Is it a hardware or a kernel problem? I now it
> > isn't a simple question with the given infos.
> > Is it possible that the 4 parallel sync processes are to much for
> > the SCSI (standard LSI) controllers?
> > I assume that the kernel RAID5 code is stable on sparc?!
> > 
> > Thank you
> > 
> > Regards
> > 
> > Marc
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
