Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287051AbSALPNK>; Sat, 12 Jan 2002 10:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287109AbSALPNB>; Sat, 12 Jan 2002 10:13:01 -0500
Received: from dialin-145-254-147-133.arcor-ip.net ([145.254.147.133]:14086
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S287051AbSALPMo>; Sat, 12 Jan 2002 10:12:44 -0500
Message-ID: <3C405254.E8D3CD54@loewe-komp.de>
Date: Sat, 12 Jan 2002 16:12:20 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Nico Schottelius <nicos@pcsystems.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: why do i get kernel panic?
In-Reply-To: <3C407FF6.3C4C0968@pcsystems.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius schrieb:
> 
> Hello dear list!
> 
> Can somebody help me to find out, why I get a kernel panic (init not
> found ) when I boot ?
> I can't understand why the kernel does not find init.
> The system I try to boot is brandnew-selfmade.
> I copied it via nfs to the hd. I ran lilo after I copied the files.
> The kernel and init resist on the second partition of the first scsi
> disc.
> The kernel includes scsi controller (aic7xxx) and disc support.
> I thought possibly the kernel tries to mount the wrong root, but there
> is
> just /dev/discs/disc0/part2 to mount, /dev/discs/disc0/part1 is swap and
> there
> are no more harddiscs.
> Passing init=/bin/sh results in the same message, although both files
> exist
> and have the x - bit set.
> 
> Anyone any idea what's wrong ?
> Please cc: me if you answer, I am not subscribed to the list anymore.
> 

just a guess:   

linux root=/dev/sda2
