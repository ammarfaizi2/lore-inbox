Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966274AbWK3M4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966274AbWK3M4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936379AbWK3M4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:56:17 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:44284 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S936364AbWK3M4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:56:15 -0500
Date: Thu, 30 Nov 2006 13:56:05 +0100
From: David Weinehall <tao@acc.umu.se>
To: Jan Dittmer <jdi@l4x.org>
Cc: Robert Hancock <hancockr@shaw.ca>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mass-storage problems with Archos AV500
Message-ID: <20061130125605.GW14886@vasa.acc.umu.se>
Mail-Followup-To: Jan Dittmer <jdi@l4x.org>,
	Robert Hancock <hancockr@shaw.ca>,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <fa.+HViQkzstd1WGzxw6QnaK2a1tiY@ifi.uio.no> <456E5F91.7020300@shaw.ca> <20061130085356.GV14886@vasa.acc.umu.se> <456EA95C.8070301@l4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456EA95C.8070301@l4x.org>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 10:50:20AM +0100, Jan Dittmer wrote:
> David Weinehall wrote:
> >On Wed, Nov 29, 2006 at 10:35:29PM -0600, Robert Hancock wrote:
> >>David Weinehall wrote:
> >>>I've got an Archos AV500 here (running the very latest firmware), pretty
> >>>much acting as a doorstop, since I cannot get it to be recognized
> >>>properly by Linux.
> >>..
> >>
> >>>[  118.144000] SCSI device sdb: 58074975 512-byte hdwr sectors (29734
> >>>MB)
> >>>[  118.144000] sdb: Write Protect is off
> >>>[  118.144000] sdb: Mode Sense: 33 00 00 00
> >>>[  118.144000] sdb: assuming drive cache: write through
> >>>[  118.144000]  sdb: unknown partition table
> >>>[  118.452000] sd 4:0:0:0: Attached scsi removable disk sdb
> >>>[  118.452000] usb-storage: device scan complete
> >>>
> >>>This is with linux-image-2.6.19-7-generic 2.6.19-7.10 from Ubuntu edgy.
> >>>I get similar results with a home-brew 2.6.18-rc4.
> >>>
> >>>Any mass storage quirk needed that might be missing?
> >>That all seems normal, other than the unknown partition table, but the 
> >>device might be all one unpartitioned disk.. at what point is it failing?
> >
> >Mounting it just claims wrong FS type.  And I've tried most file systems
> >I can think of just to be sure.
> 
> Can you read the whole volume with 'dd'? If yes, you could provide
> a hex dump of the first few sectors? Probably someone on this list will
> recognize the format...

I did this and looked into the image myself.  It definitely looks like a
FAT32 image.

I've made the first MB available here:

http://www.acc.umu.se/~tao/transfer/archos.img.bz2


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
