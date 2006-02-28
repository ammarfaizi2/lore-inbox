Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWB1TEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWB1TEd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWB1TEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:04:33 -0500
Received: from 26.mail-out.ovh.net ([213.186.42.179]:21674 "EHLO
	26.mail-out.ovh.net") by vger.kernel.org with ESMTP id S932424AbWB1TEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:04:32 -0500
Date: Tue, 28 Feb 2006 18:16:48 +0100
From: col-pepper@piments.com
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: o_sync in vfat driver
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <op.s5cj47sxj68xd1@mail.piments.com> <op.s5jpqvwhui3qek@mail.piments.com> <op.s5kxhyzgfx0war@mail.piments.com> <op.s5kx7xhfj68xd1@mail.piments.com> <op.s5kya3t0j68xd1@mail.piments.com> <op.s5ky2dbcj68xd1@mail.piments.com> <op.s5ky71nwj68xd1@mail.piments.com> <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com> <20060227132848.GA27601@csclub.uwaterloo.ca> <1141048228.2992.106.camel@laptopd505.fenrus.org> <1141049176.18855.4.camel@imp.csi.cam.ac.uk> <1141050437.2992.111.camel@laptopd505.fenrus.org> <1141051305.18855.21.camel@imp.csi.cam.ac.uk> <op.s5ngtbpsj68xd1@mail.piments.com> <Pine.LNX.4.61.0602271610120.5739@chaos.analogic.com> <op.s5nm6rm5j68xd1@mail.piments.com> <Pine.LNX.4.61.0602280745500.9291@chaos.analogic.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.s5orvmevj68xd1@mail.piments.com>
In-Reply-To: <Pine.LNX.4.61.0602280745500.9291@chaos.analogic.com>
User-Agent: Opera M2/8.51 (Linux, build 1462)
X-Ovh-Remote: 80.170.101.26 (d80-170-101-26.cust.tele2.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: fait|type 1&3|0.3|H 0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006 14:10:44 +0100, linux-os (Dick Johnson)  
<linux-os@analogic.com> wrote:

> No. That hardware was not killed by that issue. The writer, or another
> who had encountered the same issue, eventually repartitioned and
> reformatted the device. The partition table had gotten corrupted by
> some experiments and the writer assumed that the device was broken.
> It wasn't.

I did not get the info you posted from that thread so maybe I missed  
something you saw. Or indeed it was someone else.


Many thanks for your comments. If this is a false alert all the better.


> Also, the failure mode of NAND flash is not that it becomes
> "destroyed". The failure mode is a slow loss of data. The
> devices no longer retain data for a zillion years, only a
> few hundred, eventually, only a year or so.

There was a comment about the failure mode, no time scale was given. I see  
no reason why the degradation would stop at a year though.

> Since the projected life of these new devices is about 5 to 10million  
> such cycles,(older NAND flash used in modems was only 100-200k)

Maybe some of the cheap devices are not using the new flash memory in  
which case it would come down to between 24 and 48hrs of constant use.  
This would be a realistic problem.

Alan Cox refered to some devices that could be damaged as "crap", so it  
seems he is aware of some hardware differences.

In conclusion it seems from Andrew Morton's posts that the way this is  
handled is under review so I am confident that a robust and stable  
solution will result.

Thanks again for your thoughts on this.
