Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSIDSK3>; Wed, 4 Sep 2002 14:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSIDSK3>; Wed, 4 Sep 2002 14:10:29 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56069
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313190AbSIDSK2>; Wed, 4 Sep 2002 14:10:28 -0400
Date: Wed, 4 Sep 2002 11:14:23 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
cc: "ROBIN  Jean-Marie (EURIWARE)" <jmrobin@euriware.fr>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OSB4 in impossible state
In-Reply-To: <1031135030.3314.64.camel@biker.pdb.fsc.net>
Message-ID: <Pine.LNX.4.10.10209041113310.3440-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,

If you can helps build a DMA PRD list for OSB4, I know the rules.
Just I do not have the time to get to it.

On 4 Sep 2002, Martin Wilck wrote:

> Am Mit, 2002-09-04 um 11.30 schrieb ROBIN Jean-Marie (EURIWARE):
> 
> > i have installed a redhat 7.3 on a COmpaq  DL360 G2, i had a kernel panic
> > with the message "ServerWorks OSB4 in impossible state" when i mount a
> > cdrom...
> > On newsgroups archives, i look at your patch and created a new kernel.
> > Now i have no more crash but cdrom is still not accessible with the
> > following error:
> > hda: timeout waiting DMA
> > ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> > hda: status error: status 0x48 { DriveReady DataRequest }
> > hda: drive not ready
> > have you any news about this problem? No more infos on web.
> 
> Hmm - seems that DMA really doesn't work as it should. In this case my
> patch really only prevents the crash. For the moment, I can only advise
> you to start the kernel with the hda=nodma option.
> 
> I am forwarding this to Andre and Alan, who know much more about this
> than I do. It would be helpful if you could tell us your Chipset
> revision.
> 
> Martin
> 
> -- 
> Martin Wilck                Phone: +49 5251 8 15113
> Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
> Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
> D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
> 
> 
> 
> 
> 

Andre Hedrick
LAD Storage Consulting Group

