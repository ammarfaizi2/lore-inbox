Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283080AbRK1Qbm>; Wed, 28 Nov 2001 11:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283073AbRK1Qbc>; Wed, 28 Nov 2001 11:31:32 -0500
Received: from node10450.a2000.nl ([24.132.4.80]:11393 "EHLO awacs.dhs.org")
	by vger.kernel.org with ESMTP id <S283079AbRK1QbT>;
	Wed, 28 Nov 2001 11:31:19 -0500
Date: Wed, 28 Nov 2001 17:31:11 +0100
From: Pascal Haakmat <a.haakmat@chello.nl>
To: Eric Sandeen <sandeen@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: XFS Oopses with 2.4.5 and 2.4.14?
Message-ID: <20011128173111.A8093@awacs.dhs.org>
In-Reply-To: <fa.ih0gaiv.iio4rf@ifi.uio.no> <fa.ge28glv.66a6b8@ifi.uio.no> <200111281548.fASFmlI01384@mail.swdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111281548.fASFmlI01384@mail.swdata.com>; from sandeen@sgi.com on Wed, Nov 28, 2001 at 09:48:47AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

28/11/01 09:48, Eric Sandeen wrote:

> Hi Pascal - 
> 
> Did you compile these kernels yourself, and if so, what compiler did you
> use?

Yes:

Linux version 2.4.5-xfs-1.0.1 (root@awacs.dhs.org) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #10 SMP Fri Sep 21 18:34:40 CEST 2001

Linux version 2.4.14-xfs-1.0.2 (root@awacs.dhs.org) (gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-98)) #2 SMP Sun Nov 25 08:15:50 CET 2001

> Can you reproduce this reliably?

No, that is to say, I haven't tried. 

Somebody else has suggested FS corruption as the cause of these Oopses. That
might very well be the case. On multiple occassions (perhaps coinciding with
the Oopses, sorry I can't be more specific), my system has hung when trying
to write to a file, and I would be left with files looking somewhat like
this (from memory):

$ ls -lhsa spook.wav
0 -rw-r--r--    1 p        p            165k Nov 25 09:04 spook.wav

Up until now I just rm'd these files and continued, but I suppose I can try
an xfs_repair from the boot CD.

> I'd be happy to help with debugging this if you'd like, you might also
> take this over to linux-xfs@oss.sgi.com.

Thanks.
