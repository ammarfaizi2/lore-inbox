Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263829AbTDIVYZ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbTDIVYZ (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:24:25 -0400
Received: from [66.186.193.1] ([66.186.193.1]:30731 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id S263829AbTDIVYY (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 17:24:24 -0400
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 63.109.146.2
X-Authenticated-Timestamp: 17:40:03(EDT) on April 09, 2003
X-HELO-From: [10.134.0.76]
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 63.109.146.2
Subject: RE: questions regarding Journalling-FSes and w-cache reordering
From: Torrey Hoffman <thoffman@arnor.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "'Oliver S.'" <Follow.Me@gmx.net>
In-Reply-To: <1049919134.10871.5.camel@dhcp22.swansea.linux.org.uk>
References: <785F348679A4D5119A0C009027DE33C102E0D0B1@mcoexc04.mlm.maxtor.com>
	 <1049919134.10871.5.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1049924154.5404.26.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Apr 2003 14:35:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 13:12, Alan Cox wrote:
> On Mer, 2003-04-09 at 20:52, Mudama, Eric wrote:
> > ATA hard drives are allowed to reorder/merge/etc their write caches if write
> > cache is enabled.  With write caching enabled, there is no guarantee that
> > dirty data will be flushed in any specific order, nor does the ATA protocol
> > support any such ordering beyond the global flush cache command.
> 
> To cheer people up further by the way, not all ATA drives support cache
> flush, some drives dont support write cache disable and others implement
> write/verify as write.

Can anyone recommend some decent 120 GB or larger IDE drives which don't
play these games?   

I'd like to build a reliable ~1 TB RAID 5 from IDE drives.  I will
gladly give up performance for high reliability and low cost.

My current 240 GB RAID 5 is built from five 60 GB Maxtor IDEs, with a
Reiser FS on it.  I use hdparm to disable write cache... unless Maxtor
ignores that?  Does anyone know?   I can check the exact model numbers
of the drives if it matters.

Is there documentation anywhere that says which drives cut corners?
Any other suggestions on how to build a cheap but reliable RAID?

Thanks in advance,

-- 
Torrey Hoffman <thoffman@arnor.net>

