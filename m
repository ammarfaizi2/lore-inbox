Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbTJPI1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 04:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTJPI1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 04:27:44 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:31492 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S262774AbTJPI1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 04:27:42 -0400
To: linux-kernel@vger.kernel.org
From: tconnors+linuxkernel1066292516@astro.swin.edu.au
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl>
X-Face: +*%dmR:3=9i\[:8fga\UgZT#@`f=DU0(wQqI'AR2/r0sBMO}Ax\,V*cWaW-owRlUmuz&=v\KItx0:gRCBg1&z_"4x&-N#Di7))]~p2('`6|5.c3&:Z?VLU`Zt5Kb,~uC6<y}P'~7A+^'|'+iAd4t43:P;tPiT<q=9P$MO]u^@OHn1_4#qP7,XiSo21SkgI`:5=i$,t&uNN_\LfuLyH`)8!:Tb]Z
Message-ID: <slrn-0.9.7.4-15110-31210-200310161821-tc@hexane.ssi.swin.edu.au>
Date: Thu, 16 Oct 2003 18:27:39 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> said on Wed, 15 Oct 2003 15:33:05 +0200:
> On Tue, Oct 14, 2003 at 04:30:50PM -0400, Josh Litherland wrote:
> > Are there any filesystems which implement the transparent compression
> > attribute ?  (chattr +c)
> 
> The NTFS driver supports compressed files. Because it doesn't have
> proper write support, I don't think it will do anything useful with
> chattr +c.
> 
> Nowadays disks are so incredibly cheap, that transparent compression
> support is not realy worth it anymore (IMHO).

Why is it that everyone thinks things aren't necessarily done anymore?
This is the reason why we end up with *bloat* these days - people keep
on thinking it is the norm for everyone to have a computer that is
less than 3 years old.

For those of us who like not to waste, or those unfortunate not to
have a few hundred dollars spare, the statement that "disk is cheap"
(or CPU, or RAM) is a bit of an insult.

Hell, my 486 router can't even have more than the 8Megs of RAM it
already has added, due to bios/MB limitations.


Similarly, those of us with 17TB of RAID, but wanting to create 30TB
of data (on a university budget), also find compression fairly useful.
As it is, I have to write ugly hacks to get my fortran programs to be
able to make use of a pipe to gzip - my data is sufficiently redundant
that I get a good factor of 10 saving.


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
        *** System shutdown message from root ***
System going down in 60 seconds
