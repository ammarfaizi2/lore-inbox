Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273588AbRJOFr6>; Mon, 15 Oct 2001 01:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274544AbRJOFrs>; Mon, 15 Oct 2001 01:47:48 -0400
Received: from mail.sirinet.net ([198.203.196.92]:17425 "EHLO mail.sirinet.net")
	by vger.kernel.org with ESMTP id <S273588AbRJOFrf>;
	Mon, 15 Oct 2001 01:47:35 -0400
Subject: Re: IDE DVD problem under 2.4: status=0x51 { DriveReady
	SeekComplete Error }
From: John J Tobin <ogre@sirinet.net>
To: Igor Bukanov <boukanov@fi.uib.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BCA3CAF.5050807@fi.uib.no>
In-Reply-To: <3BCA3CAF.5050807@fi.uib.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 15 Oct 2001 00:40:34 -0500
Message-Id: <1003124442.32577.3.camel@ogre>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-10-14 at 20:32, Igor Bukanov wrote:
> I tried to setup my Dell Inspiron 7500 notebook (Celeron 466/512MB) with 
> TORiSAN DVD-ROM DRD-U62 (RPC-2 drive :-( ) to watch DVD and found the 
> following when using decss to read the encrypted vob files (other ways 
> to access the file eventually produce the same error) under  2.4.12 
> kernel, RedHat Linux 7.1. After I authenticated the drive and got a 
> title key for some file, css-cat always fails on the first 2-3 attempts 
> to read the file due to input-output error with kernel message:
> 
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x50
> end_request: I/O error, dev 16:00 (hdc), sector 563008
> 
Under the IDE/ATAPI configuration stuff in the kernel configuration
select the option "Use multi-mode by default." That may solve your
problem.				

-- 
John Tobin
ogre@sirinet.net; AOL IM: ogre7929
http://ogre.rocky-road.net
http://ogre.rocky-road.net/cdr.shtml

