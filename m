Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271742AbRHUQsh>; Tue, 21 Aug 2001 12:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271745AbRHUQsa>; Tue, 21 Aug 2001 12:48:30 -0400
Received: from abasin.nj.nec.com ([138.15.150.16]:39434 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S271743AbRHUQsJ>;
	Tue, 21 Aug 2001 12:48:09 -0400
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15234.37073.974320.621770@abasin.nj.nec.com>
Date: Tue, 21 Aug 2001 12:48:17 -0400 (EDT)
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P)
In-Reply-To: <20010821150202Z16034-32383+699@humbolt.nl.linux.org>
In-Reply-To: <20010820230909.A28422@oisec.net>
	<15233.37122.901333.300620@abasin.nj.nec.com>
	<15234.29508.488705.826498@abasin.nj.nec.com>
	<20010821150202Z16034-32383+699@humbolt.nl.linux.org>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, highmem was on, the stystem got 4G of memory.  I turned off
highmem and got no messages apart from one:

Aug 21 07:29:19 ps1 kernel: (scsi0:A:0:0): Locking max tag count at 64

which I was getting before.

Disk access is faster then before but still slower then the IDE
drive.  Any ideas?

Thanks for the help.

Daniel Phillips writes:
 > On August 21, 2001 04:42 pm, Sven Heinicke wrote:
 > > Forgive the sin of replying to my own message but Daniel Phillips
 > > replied to a different message with a patch to somebody getting a
 > > similar error to mine.  Here is the result:
 > > 
 > > Aug 20 15:10:33 ps1 kernel: cation failed (gfp=0x30/1). 
 > > Aug 20 15:10:33 ps1 kernel: __alloc_pages: 0-order allocation failed
 > > (gfp=0x30/1). 
 > > Aug 20 15:10:46 ps1 last message repeated 327 times 
 > > Aug 20 15:10:47 ps1 kernel: cation failed (gfp=0x30/1). 
 > > Aug 20 15:10:47 ps1 kernel: __alloc_pages: 0-order allocation failed
 > > (gfp=0x30/1). 
 > > Aug 20 15:10:56 ps1 last message repeated 294 times 
 > 
 > Are you using highmem?  Could you try it with highmem configged off?
 > 
 > --
 > Daniel
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
