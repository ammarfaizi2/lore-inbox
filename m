Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286815AbSAGU3v>; Mon, 7 Jan 2002 15:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286734AbSAGU3m>; Mon, 7 Jan 2002 15:29:42 -0500
Received: from ns2.auctionwatch.com ([64.14.24.2]:46092 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S286841AbSAGU3g>; Mon, 7 Jan 2002 15:29:36 -0500
Date: Mon, 7 Jan 2002 12:29:27 -0800
From: Petro <petro@auctionwatch.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: andihartmann@freenet.de, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020107202927.GC1227@auctionwatch.com>
In-Reply-To: <200201040019.BAA30736@webserver.ithnet.com> <3C360D6E.9020207@athlon.maya.org> <20020105092442.GC26154@auctionwatch.com> <20020105164405.5d9f5232.skraw@ithnet.com> <20020107071531.GC20760@auctionwatch.com> <20020107153348.08a4a23f.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020107153348.08a4a23f.skraw@ithnet.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 03:33:48PM +0100, Stephan von Krawczynski wrote:
> On Sun, 6 Jan 2002 23:15:31 -0800
> Petro <petro@auctionwatch.com> wrote:
> > On Sat, Jan 05, 2002 at 04:44:05PM +0100, Stephan von Krawczynski wrote:
> > > On Sat, 5 Jan 2002 01:24:42 -0800
> > > Petro <petro@auctionwatch.com> wrote:
> > > > "We" (Auctionwatch.com) are experiencing problems that appear to be
> > > > related to VM, I realize that this question was not directed at me:
> > > And how exactly do the problems look like?
> >     After some time, ranging from 1 to 48 hours, mysql quits in an
> >     unclean fashion (dies leaving tables improperly closed) with a dump
> >     in the mysql log file that looks like: 
> mysql question: is this a binary from some distro or self-compiled? If
> self-compiled can you show your ./configure paras, please?

    It's the binary from mysql.com. 
 
> >     Which the Mysql support team says appears to be memory corruption.
> >     Since this has happened on 4 different machines, and one of them had
> >     memtest86 run on it (coming up clean), they seem (witness Sasha's
> >     post) to think this may have something to do with the memory
> >     handling in the kernel. 
> There is a big difference between memory _corruption_ and a VM deficiency. No
> app can cope with a _corruption_ and is perfectly allowed to core dump or exit
> (or trash your disk). But this should not happen on allocation failures.
> Unless all your RAM is from the same series I do not really believe in mem
> corruption. I would try Martins small VM patch, as it looks like being a bit
> more efficient in low mem conditions and this may well be the case you are
> running into. This means 2.4.17 standard + patch.

     Is there a reasonable chance that martins patch will get mainlined
     in the near future? One of the big reasons I chose to upgrade to a
     later kernel version (from 2.4.8ac<something>+LVMpatches+...) was
     to get away from having to apply patches (and document which
     patches and where to get them etc). 

     If this is the route I have to go, I'll do it but, well, I'm not
     that comfortable with it. 
    
-- 
Share and Enjoy. 
