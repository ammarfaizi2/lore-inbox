Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319116AbSIDKRo>; Wed, 4 Sep 2002 06:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319117AbSIDKRo>; Wed, 4 Sep 2002 06:17:44 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:911 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S319116AbSIDKRn>; Wed, 4 Sep 2002 06:17:43 -0400
Subject: OSB4 in impossible state
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: ROBIN "Jean-Marie (EURIWARE)" <jmrobin@euriware.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <6005F8DAD235D611BDF80008C7EB75D01B008D@excsrvequ1.euriware>
References: <6005F8DAD235D611BDF80008C7EB75D01B008D@excsrvequ1.euriware>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Sep 2002 12:23:49 +0200
Message-Id: <1031135030.3314.64.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mit, 2002-09-04 um 11.30 schrieb ROBIN Jean-Marie (EURIWARE):

> i have installed a redhat 7.3 on a COmpaq  DL360 G2, i had a kernel panic
> with the message "ServerWorks OSB4 in impossible state" when i mount a
> cdrom...
> On newsgroups archives, i look at your patch and created a new kernel.
> Now i have no more crash but cdrom is still not accessible with the
> following error:
> hda: timeout waiting DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: status error: status 0x48 { DriveReady DataRequest }
> hda: drive not ready
> have you any news about this problem? No more infos on web.

Hmm - seems that DMA really doesn't work as it should. In this case my
patch really only prevents the crash. For the moment, I can only advise
you to start the kernel with the hda=nodma option.

I am forwarding this to Andre and Alan, who know much more about this
than I do. It would be helpful if you could tell us your Chipset
revision.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





