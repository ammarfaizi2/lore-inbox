Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280532AbRKFUAn>; Tue, 6 Nov 2001 15:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280554AbRKFUAd>; Tue, 6 Nov 2001 15:00:33 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:51255 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280532AbRKFUAS>; Tue, 6 Nov 2001 15:00:18 -0500
Date: Tue, 6 Nov 2001 19:59:15 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: EFS problem(s)
Message-ID: <20011106195915.B2299@grobbebol.xs4all.nl>
In-Reply-To: <20011106192344.A2299@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011106192344.A2299@grobbebol.xs4all.nl>; from roel@grobbebol.xs4all.nl on Tue, Nov 06, 2001 at 07:23:44PM +0000
X-OS: Linux grobbebol 2.4.13 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 07:23:44PM +0000, Roeland Th. Jansen wrote:
> Nov  6 19:18:24 grobbebol kernel: EFS: map_block() failed to map block 472427 (indir)
> Nov  6 19:18:24 grobbebol kernel: EFS: map_block() failed to map block 472428 (indir)
> etc. ad infinitum.
> 
> probably something wrong with the new code here ?

I also see :

Nov  6 19:56:45 grobbebol last message repeated 5 times
Nov  6 19:56:45 grobbebol kernel: EFS: extent 2049 has bgic number in block 62481gic number in block 6248103
Nov  6 19:56:45 grobbebol kernel: EFS: extent 2049 has bad magic number in block 6248103
Nov  6 19:56:45 grobbebol last message repeated 139 times
Nov  6 19:56:45 grobbebol kernel: EFS: extent 2049 has bad magic number in blocgic number in block 6248103
Nov  6 19:56:45 grobbebol kernel: EFS: extent 2049 has bad magic number in block 6248103


/mnt/panels/panels.tar is 500 MB and tar tvf shows nothing. if I now
umount and remount, the panels.tar file is ok and can be copied just
fine.

-- 
Grobbebol's Home                      |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel          | Use your real e-mail address   /\
Linux 2.4.13 (apic) SMP 466MHz/768 MB |        on Usenet.             _\_v  
