Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292977AbSBVTwE>; Fri, 22 Feb 2002 14:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292970AbSBVTvw>; Fri, 22 Feb 2002 14:51:52 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32019
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292986AbSBVTvE>; Fri, 22 Feb 2002 14:51:04 -0500
Date: Fri, 22 Feb 2002 11:38:43 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <E16eLng-0002uy-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10202221134180.2519-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Alan Cox wrote:

> > Does forcing a command to bypass the contents in the cache meaning
> > anything.  This is not a cache sync like SCSI.  It is a cache bypass and
> > will violate the journal on the down/commit block.
> 
> Thats a really useful option for a whole load of operations. Database folk
> in paticular may well benefit as will O_DIRECT stuff
> 

I agree that command mode has a proper use but the goal was to add in
write ordering barrier operations w/ a setfeature to modify the behavior
of the command.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

