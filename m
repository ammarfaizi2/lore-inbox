Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbTD2M0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbTD2M0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:26:16 -0400
Received: from mux2.uit.no ([129.242.5.252]:32010 "EHLO mux2.uit.no")
	by vger.kernel.org with ESMTP id S261968AbTD2MZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:25:30 -0400
Date: Tue, 29 Apr 2003 14:37:47 +0200
From: Tobias Brox <tobias@stud.cs.uit.no>
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: nfsroot.c + ipconfig.c (2.4.20)
Message-ID: <20030429143747.A21551@stud.cs.uit.no>
Reply-To: tobias@stud.cs.uit.no
References: <200304231510.h3NFAh430564@lgserv3.stud.cs.uit.no> <shs8yu1uqak.fsf@charged.uio.no> <20030426123356.C12540@stud.cs.uit.no> <200304291428.03465.hpj@urpla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304291428.03465.hpj@urpla.net>; from hpj@urpla.net on Tue, Apr 29, 2003 at 02:28:03PM +0200
Organization: =?iso-8859-1?Q?University_of_Troms=F8?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Hans-Peter Jansen - Tue at 02:28:03PM +0200]
> No problem here with 2.4.20, 2.5.any not yet tested. I'm doing diskless 
> since ages, but my setup seems to vary from yours. In short, I'm using 
> etherboot, tftp and mknbi. E.g.:
> 
> mknbi-linux $kernelimg $ramdisk --rootdir="/netboot/%s,v3" --ip=rom \ 
> --append="$append"

One more question; do you mount other nfs-partitions after booting?

I should probably try to play a bit more around with nfsroot.  As for
now, I skipped it completely, and chose to rely on initrd instead.  I
get grub to download a (quite big) initrd from the server, and then
it's passed to the kernel as the root system.  After booting, I can
put up network and mount partitions through nfs.

-- 
Check our new Mobster game at http://hstudd.cs.uit.no/mobster/
(web game, updates every 4th hour, no payment, no commercials)
