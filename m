Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbTA1OKV>; Tue, 28 Jan 2003 09:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbTA1OKV>; Tue, 28 Jan 2003 09:10:21 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:57099
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265477AbTA1OKU>; Tue, 28 Jan 2003 09:10:20 -0500
Date: Tue, 28 Jan 2003 06:14:20 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3ware error?  WTF is this?
In-Reply-To: <20030128140103.GE13105@rdlg.net>
Message-ID: <Pine.LNX.4.10.10301280602050.9272-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Robert,

Could you give us a little more meat to chew on?
"Kernel 2.4.19 with 3ware driver 7.5.2 from their web page", firmware ??
The driver has a version string like "1.02.00.025".
"PCI Parity Error" is more or less a mainboard error, or a barrier commit
error.  I see you are doing that favorite "jbod" thing with "md" has your
raid wrapper.  Best guess, who knows but more data is useful and required.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Tue, 28 Jan 2003, Robert L. Harris wrote:

> 
> 
> Guys, I've got a machine generating all kinds of wierd errors.  It
> failed 4 out of 8 drives on a 3ware card.  A reboot cleared all but 1
> up, I've had alot of lag while the card is spitting errors etc.  I'm
> about to launch this thing into the nearest highway I can find.
> 
> This morning I got this:
> 
> 3w-xxxx: scsi1: PCI Parity Error: clearing.
> EXT3-fs error (device md(9,2)): ext3_add_entry: bad entry in directory
> #65: rec_len % 4 != 0 - offset=552, inode=93, rec_len=21, name_len=11
> 3w-xxxx: scsi2: PCI Parity Error: clearing.
> 
> 
> Can I get an educated "oh, your card is bad" or "hmm, bad driver maybe?"
> or something I can poke with a stick?  It's a brand new box with brand
> new drives and controllers.  It was running great until last week.
> Kernel 2.4.19 with 3ware driver 7.5.2 from their web page.
> 
> Robert
> 
> 
> :wq!
> ---------------------------------------------------------------------------
> Robert L. Harris                     | PGP Key ID: FC96D405
>                                
> DISCLAIMER:
>       These are MY OPINIONS ALONE.  I speak for no-one else.
> FYI:
>  perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'
> 
> 

