Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTGAUWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 16:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbTGAUWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 16:22:24 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:5333 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263737AbTGAUWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 16:22:18 -0400
Message-ID: <3F01F13A.9030307@ccs.neu.edu>
Date: Tue, 01 Jul 2003 16:38:18 -0400
From: Stan Bubrouski <stan@ccs.neu.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?C=E9dric?= <cedriccsm2@ifrance.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 cd-writer problem
References: <3F01EB61.7030307@ifrance.com>
In-Reply-To: <3F01EB61.7030307@ifrance.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cédric,

Have you tried 2.4.21-ac4 or 2.4.22-pre2 yet?  Chances
are it is fixed in both those patchsets.

-Stan

Cédric wrote:

> Hi,
> 
> I'm having trouble with my cd-writer :
> 
> /dev/hdd:
> 
>  Model=Hewlett-Packard CD-Writer Plus 7500, FwRev=1.0a, SerialNo=YMT3WLUJLS
>  Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
>  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
>  BuffType=unknown, BuffSize=0kB, MaxMultSect=0
>  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
>  IORDY=on/off, tPIO={min:180,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
>  AdvancedPM=no
> 
> It is recognized with linux 2.4.18, and isnt with 2.4.21. My box freeze 
> at its detection.
> I've tried ide-scsi, which complains about a timeout, and freeze too.
> 
> I'm currently locked to linux 2.4.18, and thats a problem for me 
> (pthreads bug, etc..).
> 
> Does someone have a tip, an idea, or something ?
> 
> Thanks.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



