Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289767AbSBJVkR>; Sun, 10 Feb 2002 16:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289793AbSBJVkB>; Sun, 10 Feb 2002 16:40:01 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:16259 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S289767AbSBJVjl>; Sun, 10 Feb 2002 16:39:41 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Cyrille Chepelov <cyrille@chepelov.org>
Date: Mon, 11 Feb 2002 08:42:26 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15462.59714.671946.156442@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, andre@linux-ide.org,
        jmontpezat@nerim.net
Subject: Re: [RAID-soft,ATA,WD] problems with a RAID5 disc not detected 
In-Reply-To: message from Cyrille Chepelov on Sunday February 10
In-Reply-To: <20020210205653.GA20212@calixo.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday February 10, cyrille@chepelov.org wrote:
> 
> *However*, every time I boot, even though the disc is properly detected and
> its partition table read, the new WD (40 Gb) discs's partitions are ignored
> by the RAID5 autodetector. When the machine hits runlevel 2, it is possible
> to manually raidhotadd back the partitions, and after the reconstruction is
> complete, things seem to work normally, but there is obviously something
> wrong.

Are you sure that you set the partition type properly for the
partitions in the new drive. i.e. set it to FD ??

NeilBrown
