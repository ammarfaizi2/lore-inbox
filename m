Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261802AbSJNECU>; Mon, 14 Oct 2002 00:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261810AbSJNECU>; Mon, 14 Oct 2002 00:02:20 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:2003 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261802AbSJNECT>; Mon, 14 Oct 2002 00:02:19 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Stephan von Krawczynski <skraw@ithnet.com>
Date: Mon, 14 Oct 2002 13:38:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15786.15416.668502.225074@notabene.cse.unsw.edu.au>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: nfs-server slowdown in 2.4.20-pre10 with client 2.2.19
In-Reply-To: message from Stephan von Krawczynski on Monday October 14
References: <20021013172138.0e394d96.skraw@ithnet.com>
	<15785.64463.490494.526616@notabene.cse.unsw.edu.au>
	<20021014045410.4721c209.skraw@ithnet.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 14, skraw@ithnet.com wrote:
> > 
> > Very odd...  There were no changes between pre9 and pre10 that
> > directly relate to the nfs server, and none that immediately jump out
> > at me that could cause a slowdown in NFS writes.
> > 
> > What architecture?  PPC saw a lot of updates.
> 
> i386, namely dual PIII 1GHz with 1 GB RAM
> Are you sure it has nothing to do with the latest patch and SMP:
> 
> Trond Myklebust <trond.myklebust@fys.uio.no>:
>   o Workaround NFS hangs introduced in 2.4.20-pre

Nope.  This is purely client side.  The nfs server doesn't go anywhere
near this code.

> 
> > What filesystem?  jfs saw one change
> 
> reiserfs 3.6
> 
> > What storage device?  IDE or SCSI?
> 
> IDE, PDC20268
> 

Well, I cannot see any changes between pre9 and pre10 that would have
any effect on an nfs server with your configuration...

> > Can you try going back to -pre9 and confirm that performance comes
> > back?
> 
> I will have a second try on the issue this night and be back with
> info tommorrow.

Thanks.  hopefully that will shed some light.

NeilBrown
