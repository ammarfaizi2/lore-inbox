Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSLABxr>; Sat, 30 Nov 2002 20:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSLABxr>; Sat, 30 Nov 2002 20:53:47 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:16568 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261364AbSLABxq>; Sat, 30 Nov 2002 20:53:46 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200212010201.gB1210d11940@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.20-ac1
To: szepe@pinerecords.com (Tomas Szepe)
Date: Sat, 30 Nov 2002 21:01:00 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20021130183456.GJ18259@louise.pinerecords.com> from "Tomas Szepe" at Nov 30, 2002 07:34:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  	drive->using_dma = 1;
> >  	ide_toggle_bounce(drive, 1);
> > +	printk(KERN_INFO "%s: DMA enabled\n", drive->name);
> >  	return HWIF(drive)->ide_dma_host_on(drive);
> >  }
> 
> with the above applied:

Better I think that via drivers turn DMA off -quietly-
