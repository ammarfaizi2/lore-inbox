Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266580AbRG1MRP>; Sat, 28 Jul 2001 08:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266582AbRG1MRE>; Sat, 28 Jul 2001 08:17:04 -0400
Received: from [209.226.93.226] ([209.226.93.226]:59900 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S266580AbRG1MQu>; Sat, 28 Jul 2001 08:16:50 -0400
Date: Sat, 28 Jul 2001 08:15:55 -0400
Message-Id: <200107281215.f6SCFt716350@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: "Martin Wilck" <Martin.Wilck@fujitsu-siemens.com>,
        "devfs mailing list" <devfs@oss.sgi.com>,
        "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: ide-floppy & devfs
In-Reply-To: <000701c116f5$8268a820$6baaa8c0@kevin>
In-Reply-To: <Pine.LNX.4.30.0107272127060.16993-100000@biker.pdb.fsc.net>
	<000701c116f5$8268a820$6baaa8c0@kevin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Kevin P. Fleming writes:
> Also note that I have already forwarded a patch to Richard to make
> the devfs nodes that get created when grok_partitions runs get
> removed when the media is removed and new media is validated
> (i.e. the partition nodes will stay in sync with the cartridge in
> the drive).

Are you saying that the two patch conflict? If not, can someone please
verify that both together are safe? Or is your patch a superset?

Either way, I can't really test these patches since I don't have
removable media devices, so I'd prefer if someone else nurses this
into Linus' tree (i.e. test it, call for testing and feed it to Linus
until it goes in).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
