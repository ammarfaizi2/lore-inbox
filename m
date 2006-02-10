Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWBJMCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWBJMCE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWBJMCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:02:04 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:29912 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751097AbWBJMCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:02:03 -0500
Date: Fri, 10 Feb 2006 13:01:58 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: libATA  PATA status report, new patch
Message-ID: <20060210120157.GB28676@harddisk-recovery.com>
References: <20060207084347.54CD01430C@rhn.tartu-labor> <1139310335.18391.2.camel@localhost.localdomain> <Pine.SOC.4.61.0602071305310.10491@math.ut.ee> <1139312330.18391.14.camel@localhost.localdomain> <1139324653.18391.41.camel@localhost.localdomain> <Pine.SOC.4.61.0602082024010.21660@math.ut.ee> <1139499102.1255.45.camel@localhost.localdomain> <Pine.SOC.4.61.0602092307460.16686@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0602092307460.16686@math.ut.ee>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 11:12:27PM +0200, Meelis Roos wrote:
> >Thanks: Utterly dumb bug made while converting to the newer refcounting
> >PCI API
> 
> Yes, it boots now. But reading the disk fails - partition table reading 
> bails out. Maybe this is the same early command problem that affects 
> other controllers too.

Alan, can this related to LBA48 compatibility? I remember having
problems with this when Andre Hedrick added LBA48 support around
linux-2.4.19. The drive (Maxtor 4D040H2) advertised it supported LBA48,
but the chipset (Ali 1543 rev C3, IIRC) didn't.

Unfortunately I can't test it, my Ali main board died a couple of
months ago so I'm just guessing :-(.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
