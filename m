Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319068AbSHFLbd>; Tue, 6 Aug 2002 07:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319070AbSHFLbd>; Tue, 6 Aug 2002 07:31:33 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:52658 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S319068AbSHFLbd>; Tue, 6 Aug 2002 07:31:33 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Tommy Faasen" <faasen@xs4all.nl>
Date: Tue, 6 Aug 2002 21:35:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15695.46226.763861.953550@notabene.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 (pre8) strange software raid0 problem
In-Reply-To: message from Tommy Faasen on Tuesday August 6
References: <32838.192.168.0.100.1028462137.squirrel@mail.zwanebloem.nl>
	<15693.5974.487891.772395@notabene.cse.unsw.edu.au>
	<2289.198.43.100.6.1028615479.squirrel@mail.zwanebloem.nl>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 6, faasen@xs4all.nl wrote:

> Well, that's just it, I was/am using autodetect partitions.
> if I run raidstart -a or raidstart /dev/md0 it says something like "
> strarting /dev/md0 succes!". However when I try to mount it it fails, only
> the mdmadm command seems to work?

I guess more detail is needed.
Can you give me complete dmesg logs of the booting processes,
particularly where it attempts to assemble the RAID array.

NeilBrown
