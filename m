Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293623AbSCKFsS>; Mon, 11 Mar 2002 00:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293624AbSCKFsH>; Mon, 11 Mar 2002 00:48:07 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15622
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293623AbSCKFsB>; Mon, 11 Mar 2002 00:48:01 -0500
Date: Sun, 10 Mar 2002 21:47:23 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Reid Hekman <reid_hekman@yahoo.com>
cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Suspend support for IDE
In-Reply-To: <1015805489.15071.10.camel@zeus>
Message-ID: <Pine.LNX.4.10.10203102145340.9328-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Mar 2002, Reid Hekman wrote:

> On Sat, 2002-03-09 at 18:52, Barry K. Nathan wrote: 
> > > > Why should I tell the drive to power down? It is going to loose its
> > > > power, anyway (I believe in both S3 and S4).
> > > 
> > > So it can shut itself down nicely and do any housework it wants to do
> > > (like flushing the cache if the cache flush command isnt supported.. its
> > >  optional in older ATA standards)
> > 
> > Or, in the case of newer IBM TravelStars, so that the drive can unload
> > its head properly instead of having to do an uncontrolled emergency unload
> > that shortens the drive's life and makes an awful screeching noise.
> 
> Eeep. Have we just set the wayback machine for 15 years ago? I don't
> remember seeing PARK.COM in /sbin recently. 
> 
> Sorry, couldn't resist. 

No, I put it in the NOTIFY calls with some help from Tim Hockin!
Since the end-user generally does not need to know how to deal w/ these
issues, the kernel had better get smart but who knows if it made in in
there in 2.4 yet and whether it got broke in 2.5 or not.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

