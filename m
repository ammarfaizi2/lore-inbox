Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261821AbSJNCsf>; Sun, 13 Oct 2002 22:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261820AbSJNCse>; Sun, 13 Oct 2002 22:48:34 -0400
Received: from ns.ithnet.com ([217.64.64.10]:34054 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S261821AbSJNCsd>;
	Sun, 13 Oct 2002 22:48:33 -0400
Date: Mon, 14 Oct 2002 04:54:10 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: nfs-server slowdown in 2.4.20-pre10 with client 2.2.19
Message-Id: <20021014045410.4721c209.skraw@ithnet.com>
In-Reply-To: <15785.64463.490494.526616@notabene.cse.unsw.edu.au>
References: <20021013172138.0e394d96.skraw@ithnet.com>
	<15785.64463.490494.526616@notabene.cse.unsw.edu.au>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002 09:03:43 +1000
Neil Brown <neilb@cse.unsw.edu.au> wrote:

> On Sunday October 13, skraw@ithnet.com wrote:
> > Hello Trond, 
> > hello all,
> > 
> > just to drop a note: I am experiencing a rather dramatic slowdown of the
> > nfs-server in kernel 2.4.20-pre10 in conjunction with nfs-clients kernel
> > 2.2.19. To be more specific, the server is a SMP machine and runs always the
> > latest 2.4.x  kernels. Upto 2.4.20-pre9 everything was quite ok, but pre10
> > brought an incredible loss. The setup did not change, only the kernel on the
> > server side. Merely all nfs action is writing to the server, reading from it is
> > next to zero in this setup.
> 
> Very odd...  There were no changes between pre9 and pre10 that
> directly relate to the nfs server, and none that immediately jump out
> at me that could cause a slowdown in NFS writes.
> 
> What architecture?  PPC saw a lot of updates.

i386, namely dual PIII 1GHz with 1 GB RAM
Are you sure it has nothing to do with the latest patch and SMP:

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Workaround NFS hangs introduced in 2.4.20-pre

> What filesystem?  jfs saw one change

reiserfs 3.6

> What storage device?  IDE or SCSI?

IDE, PDC20268

> Can you try going back to -pre9 and confirm that performance comes
> back?

I will have a second try on the issue this night and be back with info tommorrow.

Thanks, 
Stephan


> NeilBrown

