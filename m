Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272196AbRIJXx0>; Mon, 10 Sep 2001 19:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272195AbRIJXxR>; Mon, 10 Sep 2001 19:53:17 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:64517 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S272193AbRIJXxD>; Mon, 10 Sep 2001 19:53:03 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Michael S. Fischer" <michael@auctionwatch.com>
Date: Tue, 11 Sep 2001 08:51:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15261.17407.263707.28101@notabene.cse.unsw.edu.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Oops in md_error/set_disk_faulty
In-Reply-To: message from Michael S. Fischer on Wednesday September 5
In-Reply-To: <5179B27750A9D411B968009027E06E2702EB5FCE@exback.corp.auctionwatch.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday September 5, michael@auctionwatch.com wrote:
> Kernel: 2.4.8-ac8
> raidsetfaulty v0.3d compiled for md raidtools-0.90
> 
> I accidentally entered the wrong disk device in a raidsetfaulty command,
> which caused a kernel oops and appears to have locked the thread (so that
> subsequent commands just hang).
> 
> The md device in question was:
> 
> md2 : active raid1 sdb4[0] sda4[1]
>       5839552 blocks [2/2] [UU]
> 
> And the command I entered was 
> 
> # raidsetfaulty /dev/md2 /dev/hdb4 
> Segmentation fault

This is fixed in 2.4.10-pre5.

NeilBrown
