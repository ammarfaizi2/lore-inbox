Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312942AbSDOGOq>; Mon, 15 Apr 2002 02:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312982AbSDOGOp>; Mon, 15 Apr 2002 02:14:45 -0400
Received: from dns.vamo.orbitel.bg ([195.24.63.30]:7185 "EHLO
	dns.vamo.orbitel.bg") by vger.kernel.org with ESMTP
	id <S312942AbSDOGOp>; Mon, 15 Apr 2002 02:14:45 -0400
Date: Mon, 15 Apr 2002 09:14:30 +0300 (EEST)
From: Ivan Ivanov <ivandi@vamo.orbitel.bg>
To: Jan Kara <jack@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 quota bug in 2.4.18
In-Reply-To: <20020414205321.GA9108@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0204150906380.21417-100000@dns.vamo.orbitel.bg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Apr 2002, Jan Kara wrote:

> > Jan Kara wrote:
> >
> > > > on ext2 filesystem chown/chgroup doesn't change quota
> > > > ext3 is OK
> > >   Kernel version, quota utils version, etc...?
> > >
> > >                                                 Honza
> >
> > kernel 2.4.18
> > quota 2.00 and 3.04
> >
> > also
> > kernel 2.4.18 with 50_quota-patch-2.4.15-2.4.16 + dquot_deadlock.diff
> >
> > ext3 works fine
>   Sorry it took me so long to reply. I tried to reproduce your problem
> but I haven't succeeded. Is quota really turned on on the filesystem?
> Did you know which kernel version was the last working?
>
> 								Honza
> --
> Jan Kara <jack@suse.cz>
> SuSE CR Labs
>
>

I think the problem was ACL end EA patch. I am sorry, I forget that the
kernel was patched with acl/ea-0.8.25 too. Without this patch everything
is OK.

Thanks for reply

Ivan



