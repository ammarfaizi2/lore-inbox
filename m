Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129355AbRCIB27>; Thu, 8 Mar 2001 20:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129283AbRCIB2u>; Thu, 8 Mar 2001 20:28:50 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:11027 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129115AbRCIB2e>; Thu, 8 Mar 2001 20:28:34 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "otto meier" <gf435@gmx.net>
Date: Fri, 9 Mar 2001 11:17:38 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15016.8482.907782.796924@notabene.cse.unsw.edu.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Subject: Re: Kernel crash during resync of raid5 on SMP
In-Reply-To: message from Otto Meier on Thursday March 8
In-Reply-To: <15014.44624.26763.798524@notabene.cse.unsw.edu.au>
	<200103081519.f28FJ9u05622@gate2.private.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 8, gf435@gmx.net wrote:
> On Thu, 8 Mar 2001 08:55:28 +1100 (EST), Neil Brown wrote:
> 
> >On Wednesday March 7, gf435@gmx.net wrote:
> >> I run a Dual prozessor SMP system on 2.4.2-ac12 for a while
> >> in degraded mode. Today I put in a new disk to switch to
> >> full raid5 mode. Shortly after the command raidhotadd  the 
> >> system crashed with the message lost interrupt on cpu1.
> >
> >Was there an Oops? Can we see? decoded with ksymoops of course.
> 
> Unfortunatly I entered this command remotely. The console Display was
> off at that time.
> 
> >Are you happy to retry? (i.e. raidsetfaulty; raidhotremove,
> >raidhotadd).  If so, Could you try with 2.4.2?
> 
> I would not really like to do that, as of now everything runs fine again for a day.
> 

Fair enough.  When I get my test machine back I might do some testing
and see if I can reproduce it.
In the mean time, if anyone else sees it and gets an Oops,  I would be
interested to see it.

NeilBrown
