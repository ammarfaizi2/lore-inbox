Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbTB0MRl>; Thu, 27 Feb 2003 07:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbTB0MRl>; Thu, 27 Feb 2003 07:17:41 -0500
Received: from ltgp.iram.es ([150.214.224.138]:30080 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id <S264745AbTB0MRk>;
	Thu, 27 Feb 2003 07:17:40 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 27 Feb 2003 13:26:51 +0100
To: Miles Bader <miles@gnu.org>
Cc: Kasper Dupont <kasperd@daimi.au.dk>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030227122651.GA6444@iram.es>
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DB2CA.32539D41@daimi.au.dk> <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DCB89.9086582F@daimi.au.dk> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DDE5A.1BCD0747@daimi.au.dk> <buor89uqc2k.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buor89uqc2k.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 06:58:59PM +0900, Miles Bader wrote:
> Kasper Dupont <kasperd@daimi.au.dk> writes:
> > > > But AFAIK fsck uses mtab.
> > > 
> > > It uses /etc/fstab.
> > 
> > [kasperd:pts/0:~] grep /etc/mtab /sbin/fsck*
> > Binary file /sbin/fsck.ext2 matches
> > Binary file /sbin/fsck.ext3 matches
> > Binary file /sbin/fsck.minix matches
> > [kasperd:pts/0:~] 
> 
> God know why; the versions (e2fsprogs 1.32) on my system don't, so it's
> probably not something very important.  fsck should still work fine.

Do you have a statically or dynamically linked e2fsck? On my system
/etc/mtab is not in /sbin/e2fsck but it is in /lib/libext2fs.so.2 and
also in the statically linked version of e2fsck.

	Gabriel
