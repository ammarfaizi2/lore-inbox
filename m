Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271859AbRHUWok>; Tue, 21 Aug 2001 18:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271882AbRHUWoa>; Tue, 21 Aug 2001 18:44:30 -0400
Received: from abasin.nj.nec.com ([138.15.150.16]:48650 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S271859AbRHUWoP>;
	Tue, 21 Aug 2001 18:44:15 -0400
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15234.58438.146372.874293@abasin.nj.nec.com>
Date: Tue, 21 Aug 2001 18:44:22 -0400 (EDT)
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P)
In-Reply-To: <20010821172029Z16065-32384+285@humbolt.nl.linux.org>
In-Reply-To: <20010820230909.A28422@oisec.net>
	<20010821150202Z16034-32383+699@humbolt.nl.linux.org>
	<15234.37073.974320.621770@abasin.nj.nec.com>
	<20010821172029Z16065-32384+285@humbolt.nl.linux.org>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Great, with 2.4.8-ac8 I get no memory problems.  Can you tell me what
file(s) where modified to fix this to I can look for the fixes in
future vanilla kernels?

Thanks!  Now to work on the drive speed problem, it's faster with your
fix but still slower at writing then my IDE drive on another systems.

       Sven

Daniel Phillips writes:
 > On August 21, 2001 06:48 pm, Sven Heinicke wrote:
 > > Yes, highmem was on, the stystem got 4G of memory.  I turned off
 > > highmem and got no messages apart from one:
 > > 
 > > Aug 21 07:29:19 ps1 kernel: (scsi0:A:0:0): Locking max tag count at 64
 > > 
 > > which I was getting before.
 > >
 > > Disk access is faster then before but still slower then the IDE
 > > drive.  Any ideas?
 > 
 > Two separate problems, I think.  I don't know anything about the aic7xxx 
 > driver but I can take a look at the highmem problem.  First, can you try
 > it with highmem enabled, on a recent -ac kernel, say 2.4.8-ac7.
 > 
 > --
 > Daniel
