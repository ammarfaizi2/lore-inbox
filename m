Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUGXL1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUGXL1M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 07:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268471AbUGXL1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 07:27:12 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:45014 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264231AbUGXL1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 07:27:10 -0400
Date: Sat, 24 Jul 2004 13:27:06 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: max request size 1024KiB by default?
Message-ID: <20040724112706.GA31077@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	linux-kernel@vger.kernel.org
References: <20040712174639.38c7cf48.akpm@osdl.org> <1089687168.10777.126.camel@mindpipe> <20040712205917.47d1d58b.akpm@osdl.org> <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu> <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu> <20040720121905.GG1651@suse.de> <1090642050.2871.6.camel@mindpipe> <1090647952.1006.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090647952.1006.7.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> HD info:
> /dev/hdc:
> 
>  Model=Maxtor 6Y160P0, FwRev=YAR41BW0, SerialNo=Y44K8TZE
>  Config={ Fixed }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
>  BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=16
>  CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=268435455
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4 
>  DMA modes:  mdma0 mdma1 mdma2 
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
>  AdvancedPM=yes: disabled (255) WriteCache=enabled
>  Drive conforms to: (null): 

Hello.

I was just wondering why the default max request size is 128KiB on my drive,
which is almost the same as the one you tested?!

/dev/hda:

 Model=Maxtor 6Y120P0, FwRev=YAR41BW0, SerialNo=...
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):

 * signifies the current active mode

Thanks.

Rudo.
