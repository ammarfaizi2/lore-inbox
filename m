Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWD0RMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWD0RMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 13:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWD0RMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 13:12:03 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:33228 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S965165AbWD0RMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 13:12:02 -0400
Date: Thu, 27 Apr 2006 13:12:01 -0400
From: Yaroslav Halchenko <kernel@onerussian.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Highpoint SATA RAID (khe khe) status -- oopses, crashes, etc
Message-ID: <20060427171201.GG17639@washoe.onerussian.com>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20060425172356.GD15201@washoe.onerussian.com> <20060426190657.GA17639@washoe.onerussian.com> <20060427053528.GB17639@washoe.onerussian.com> <20060427164933.GF17639@washoe.onerussian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427164933.GF17639@washoe.onerussian.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just a follow-up: many modules (seems to be IDE related ones) are marked
as permanent... I bet it is due to hacked hpt366...
I hope that I will not need to unload them (most of them are not used
anyways)...

raider:/dev# lsmod | grep permanent
hpt366                 21376  0 [permanent]
ide_generic             2944  0 [permanent]
pdc202xx_new           11264  0 [permanent]
aec62xx                 9728  0 [permanent]
alim15x3               13848  0 [permanent]
amd74xx                17200  0 [permanent]
atiixp                  8464  0 [permanent]
cmd64x                 13644  0 [permanent]
cs5520                  6784  0 [permanent]
cs5530                  7680  0 [permanent]
cy82c693                6664  0 [permanent]
generic                 7172  0 [permanent]
hpt34x                  7168  0 [permanent]
ns87415                 6216  0 [permanent]
pdc202xx_old           13184  0 [permanent]
piix                   14212  0 [permanent]
sc1200                  9344  0 [permanent]
serverworks            11024  0 [permanent]
siimage                13952  0 [permanent]
sis5513                18064  0 [permanent]
slc90e66                8448  0 [permanent]
triflex                 5888  0 [permanent]
trm290                  6276  0 [permanent]
via82cxxx              11012  0 [permanent]


On Thu, 27 Apr 2006, Yaroslav Halchenko wrote:

> Hi Woody and everyone,

> Woody's patch (without any tweaking) applied to 2.6.16.11 allowed to
> load the drivers without oopsing and drives hd[eg] got visible.
> As "promised" dma is unavailable feature and speeds (according to md
> syncing) are quite low: 691K/sec

> Thank you Woody once again
-- 
Yaroslav Halchenko
Research Assistant, Psychology Department, Rutgers-Newark
Office: (973) 353-5440x263 | FWD: 82823 | Fax: (973) 353-1171
        101 Warren Str, Smith Hall, Rm 4-105, Newark NJ 07105
Student  Ph.D. @ CS Dept. NJIT
