Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTD3KL1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 06:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbTD3KL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 06:11:27 -0400
Received: from WARSL401PIP8.highway.telekom.at ([195.3.96.97]:47420 "HELO
	email01.aon.at") by vger.kernel.org with SMTP id S261893AbTD3KL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 06:11:26 -0400
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Linux-2.4.20 on a 4 MB Laptop - Kernel bug?
Date: Wed, 30 Apr 2003 12:23:38 +0200
User-Agent: KMail/1.5
Cc: Nuno Silva <nuno.silva@vgertech.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.10.10304300255510.20264-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10304300255510.20264-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304301223.38246.dusty@violin.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 April 2003 11:57, Andre Hedrick wrote:
> On Wed, 30 Apr 2003, Hermann Himmelbauer wrote:
> > On Thursday 10 April 2003 04:53, Nuno Silva wrote:
> > > Hello!
> > >
> > > Hermann Himmelbauer wrote:
> > > > Well - anyway, the kernel boots but right stops after:
> > > > INIT: Entering runlevel:3
> > > >
> > > > The next line is:
> > > > INIT: open(/dev/console): Input/output error
> > > > INIT: Id "2" respawning too fast: disabled for 5 minutes
> > > > ...
> > > >
> > > > That's it.
> > >
> > > Maybe you striped too much and didn't include *any* console type
> > > (serial, vga or framebuffer)? :)
> >
> > Well - by chance we found another old Laptop, an IBM Thinkpad 350 (the
> > old was model 340) and found a RAM extension, so we have no 36MB RAM.
> >
> > But - guess what: The error still persists!
> >
> > I am quite clueless - maybe it has something to do with the IDE
> > subsystem? We put a 4GB 2.5'' HD in this old Laptop, but the harddisk is
> > correctly recognized by Linux (also Partition check), grub is also
> > working and it Linux also mounts the partition.
>
> So if it works, why do you claim a bug in the IDE subsystem?
> Because  it is an easy target and if all else fails, it is must be IDE ?

Well, I basically thought the combination of my recent 4GB harddisk + the old 
IDE hardware causes troubles.

But you're right, it can be anything else - but there is nothing special about 
this old laptop - moreover the error occured in both models. So I just 
guessed that there could be an IDE hardware flaw which is not uncommon with 
old hardware.

But, what else could it be? The console driver? UNIX 98 PTY? Perhaps the math 
emulation (486SL has no coprocessor) makes troubles?

I'm absolutely clueless...

		Best Regards,
		Hermann

-- 
x1@aon.at
GPG key ID: 299893C7 (on keyservers)
FP: 0124 2584 8809 EF2A DBF9  4902 64B4 D16B 2998 93C7

