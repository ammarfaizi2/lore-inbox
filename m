Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289382AbSAVUNZ>; Tue, 22 Jan 2002 15:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289383AbSAVUNP>; Tue, 22 Jan 2002 15:13:15 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60942 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289382AbSAVUNI> convert rfc822-to-8bit; Tue, 22 Jan 2002 15:13:08 -0500
Date: Tue, 22 Jan 2002 15:12:07 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
cc: "Alok K. Dhir" <alok@dhir.net>, linux-kernel@vger.kernel.org
Subject: Re: Autostart RAID 1+0 (root)
In-Reply-To: <20020122184600.C11697@unthought.net>
Message-ID: <Pine.LNX.3.96.1020122150722.28222A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, [iso-8859-1] Jakob Østergaard wrote:

> On Tue, Jan 22, 2002 at 12:15:28PM -0500, Bill Davidsen wrote:

> I think he is referring to software RAID. And yes, it is indeed a problem
> that the RedHat installer cannot create nested RAIDs (at least, I too was
> unable to do that, so either it's impossible, or I'm equally blind).

  The RH installer also won't do RAID from a text install, so if you lack
memory or the right graphic card you just can't do the install at all
(unless I miss something). What good is install from serial console if you
can't use any setup but the big blob?

> 
> > This is because if the first disk fails totally, the 2nd will be used to
> > boot. You also should use an initrd image to be sure all you need to get
> > up is on that small mirrored partition. After that your other partitions
> > can be whatever pleases you.
> 
> Also, GRUB/LILO only support booting from RAID-1 (or no RAID).

  Another factor, for sure. Fortunately I believe only the boot partition
needs to be RAID-1, after that the kernel should take over.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

