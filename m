Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261711AbSJMW6O>; Sun, 13 Oct 2002 18:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261761AbSJMW6O>; Sun, 13 Oct 2002 18:58:14 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:53446 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261711AbSJMW6N>; Sun, 13 Oct 2002 18:58:13 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Stephan von Krawczynski <skraw@ithnet.com>
Date: Mon, 14 Oct 2002 09:03:43 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15785.64463.490494.526616@notabene.cse.unsw.edu.au>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs-server slowdown in 2.4.20-pre10 with client 2.2.19
In-Reply-To: message from Stephan von Krawczynski on Sunday October 13
References: <20021013172138.0e394d96.skraw@ithnet.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 13, skraw@ithnet.com wrote:
> Hello Trond, 
> hello all,
> 
> just to drop a note: I am experiencing a rather dramatic slowdown of the
> nfs-server in kernel 2.4.20-pre10 in conjunction with nfs-clients kernel
> 2.2.19. To be more specific, the server is a SMP machine and runs always the
> latest 2.4.x  kernels. Upto 2.4.20-pre9 everything was quite ok, but pre10
> brought an incredible loss. The setup did not change, only the kernel on the
> server side. Merely all nfs action is writing to the server, reading from it is
> next to zero in this setup.

Very odd...  There were no changes between pre9 and pre10 that
directly relate to the nfs server, and none that immediately jump out
at me that could cause a slowdown in NFS writes.

What architecture?  PPC saw a lot of updates.
What filesystem?  jfs saw one change
What storage device?  IDE or SCSI?

Can you try going back to -pre9 and confirm that performance comes
back?

NeilBrown
