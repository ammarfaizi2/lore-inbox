Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129284AbRBZRdR>; Mon, 26 Feb 2001 12:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbRBZRc6>; Mon, 26 Feb 2001 12:32:58 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:20486
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129280AbRBZRcw>; Mon, 26 Feb 2001 12:32:52 -0500
Date: Mon, 26 Feb 2001 09:32:03 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Guest section DW <dwguest@win.tue.nl>,
        Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: partition table: chs question
In-Reply-To: <20010226112232.B23495@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.10.10102260929080.28790-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2001, Jeff V. Merkey wrote:

> On Sun, Feb 25, 2001 at 05:59:33PM -0800, Andre Hedrick wrote:
> > 
> > 
> > It does not matter because the usage of CHS will dies soon because it was
> > voted to death in Austin last week.  There will only be LBA addressing
> > from now on out.
> 
> If someone has Linux and NetWare dual booted on a system, and does not 
> fill out the CHS fields properly for NetWare partitions, When NetWare 
> boots, it will wipe the partition table (it will ask you first) and 
> will not recognize any of the partitions.  It does this because if it 
> sees CHS values it does not expect, it assumes the partition table 
> has been corrupted.

Then Netware is a bad HOST-Driver and people should expect to be hurt by
using a HOST that is not compliant.  It is the responsiblity of the user
to tell the HOST-OS what it needs to do.  Especially if one of the OSes
can not be intelligent enough to adpat to the changes.

Regards,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

