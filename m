Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbQLUXwT>; Thu, 21 Dec 2000 18:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130560AbQLUXwI>; Thu, 21 Dec 2000 18:52:08 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:31763 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130139AbQLUXv5>; Thu, 21 Dec 2000 18:51:57 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: John Covici <covici@ccs.covici.com>
Date: Fri, 22 Dec 2000 10:21:14 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14914.36970.774601.96539@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange nfs behavior in 2.2.18 and 2.4.0-test12
In-Reply-To: message from John Covici on Thursday December 21
In-Reply-To: <14914.32991.480115.210561@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.21.0012211813110.840-100000@ccs.covici.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday December 21, covici@ccs.covici.com wrote:
> On Fri, 22 Dec 2000, Neil Brown wrote:
> 
> > On Thursday December 21, covici@ccs.covici.com wrote:
> > > Hi.  I am having strange nfs problems in both my 2.x and 2.4.0-test12
> > > kernels.
> > > 
> > > What is happening is that when the machine boots up and exports the
> > > directories for nfs, it complains that
> > > 
> > > ccs2:/ invalid argument .
> > > 
> > > The exports entry is
> > > 
> > > / ccs2(rw,no_root_squash)
> > 
> > Is there another export entry that exports another part of the same
> > file system to the same client?  If so, that is your problem.
> 
> Well I do want to export the mount points under the file system, for
> instance I have a partition mounted as /usr and so I have an entry
> such as
> /usr ccs2(rw,no_root_squash)
> 
> in my exports list.  Is there any other way to get this behaviour to
> work?

Sounds like what you are doing is OK.
If you could send complete /etc/fstab and /etc/exports, that might
help to isolate the problem.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
