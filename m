Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312457AbSDNUxU>; Sun, 14 Apr 2002 16:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312458AbSDNUxT>; Sun, 14 Apr 2002 16:53:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8714 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312457AbSDNUxT>; Sun, 14 Apr 2002 16:53:19 -0400
Date: Sun, 14 Apr 2002 22:53:21 +0200
From: Jan Kara <jack@suse.cz>
To: Ivan Ivanov <ivandi@vamo.orbitel.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 quota bug in 2.4.18
Message-ID: <20020414205321.GA9108@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3CA8A379.EA510E15@vamo.orbitel.bg> <20020408144431.GB23734@atrey.karlin.mff.cuni.cz> <3CB1CF4D.794AAFFE@vamo.orbitel.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan Kara wrote:
> 
> > > on ext2 filesystem chown/chgroup doesn't change quota
> > > ext3 is OK
> >   Kernel version, quota utils version, etc...?
> >
> >                                                 Honza
> 
> kernel 2.4.18
> quota 2.00 and 3.04
> 
> also
> kernel 2.4.18 with 50_quota-patch-2.4.15-2.4.16 + dquot_deadlock.diff
> 
> ext3 works fine
  Sorry it took me so long to reply. I tried to reproduce your problem
but I haven't succeeded. Is quota really turned on on the filesystem?
Did you know which kernel version was the last working?

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
