Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137172AbREKQxb>; Fri, 11 May 2001 12:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137174AbREKQxW>; Fri, 11 May 2001 12:53:22 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:35332 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S137172AbREKQxN>; Fri, 11 May 2001 12:53:13 -0400
Date: Fri, 11 May 2001 18:53:11 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
Message-ID: <20010511185311.A6756@burns.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01050910381407.26653@bugs> <20010510134453.A6816@emma1.emma.line.org> <3AFA9AD8.7080203@magenta-netlogic.com> <20010511013726.C31966@emma1.emma.line.org> <3AFBFDB0.5080904@magenta-netlogic.com> <20010511175605.G28282@burns.dt.e-technik.uni-dortmund.de> <3AFC178F.3090806@magenta-netlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFC178F.3090806@magenta-netlogic.com>; from tmh@magenta-netlogic.com on Fri, May 11, 2001 at 17:47:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2001, Tony Hoyle wrote:

> ls can't access the files either, so I don't see how that could rectify 
> anything.  The entire directory becomes inaccessible.   This happened to 
> /lib once.  Nasty.

No-one can access the files once the caches are hosed. Purge the
inode/dentry caches and retry.

> I'd like to be able to use something like reiserfs, especially when 
> developing (it reduces boot time a lot).  However to call it 'stable' on 
> 2.4.4 is simply wrong.  If/when the nfs fix gets merged and tested 
> *then* it stands a chance of being called stable.

Does that actually apply to 2.4.4 or rather to 2.2.19?
