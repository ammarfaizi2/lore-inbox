Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUGPP7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUGPP7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 11:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266564AbUGPP7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 11:59:16 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:44554 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S266561AbUGPP7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 11:59:14 -0400
From: Meelis Roos <mroos@linux.ee>
To: schu@schu.net, linux-kernel@vger.kernel.org
Subject: Re: Possible bug with kernel decompressor.
In-Reply-To: <40F490B6.6000106@schu.net>
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.7 (i686))
Message-Id: <E1BlV5r-0003Pc-JJ@rhn.tartu-labor>
Date: Fri, 16 Jul 2004 18:57:51 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MS> invalid compressed format (err=2)
MS> 
MS>    --System halted

I had the same on Digital Celebris 5133. One debian Woody boot floppy I
tried (don't remember which flavour) gave exactly this. Debian Sarge
boot floppies worked fine.

Additionally, lilo didn't work, just hung.

Grub does work but something (BIOS?) garbles some of the kernel command
line. I used the following kernel command line as a workaround:
abrakadabra my_real_options...
and this became
PAMSkadabra my_real_options...

Other than that it worked fine - Pentium 133, 64M RAM, onboard Adaptec
SCSI, onboard Matrox video.

-- 
Meelis Roos
