Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130441AbRBGUyy>; Wed, 7 Feb 2001 15:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129832AbRBGUyo>; Wed, 7 Feb 2001 15:54:44 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:33290
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129063AbRBGUyY>; Wed, 7 Feb 2001 15:54:24 -0500
Date: Wed, 7 Feb 2001 12:53:36 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, "A.Sajjad Zaidi" <sajjad@vgkk.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Promise, DMA and RAID5 problems running 2.4.1
In-Reply-To: <E14QarA-0001DC-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10102071253121.5890-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, Alan Cox wrote:

> > Iff CONFIG_BLK_DEV_IDECS is set then yes, doing schedule is better.
> > But I do not see any benefit in doing
> > 
> > unsigned long timeout = jiffies + ((HZ + 19)/20) + 1;
> > while (0 < (signed long)(timeout - jiffies));
> 
> On that bit we agree.

What do you want fixed?
Send a patch and lets try it....

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
