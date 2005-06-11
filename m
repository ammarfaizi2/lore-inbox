Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVFKTIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVFKTIj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVFKTIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:08:36 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:19400 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261623AbVFKTIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:08:31 -0400
Date: Sat, 11 Jun 2005 21:08:28 +0200
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Lord <lord@xfs.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
Message-ID: <20050611190828.GB22599@ojjektum.uhulinux.hu>
References: <42A99D9D.7080900@xfs.org> <20050610112515.691dcb6e.akpm@osdl.org> <20050611082642.GB17639@ojjektum.uhulinux.hu> <42AAE5C8.9060609@xfs.org> <20050611150525.GI17639@ojjektum.uhulinux.hu> <42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611120040.084942ed.akpm@osdl.org>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 12:00:40PM -0700, Andrew Morton wrote:
> >  I disabled hyperthreading and things started working, so are there any
> >  HT related scheduling bugs right now?
> 
> There haven't been any scheduler changes for some time.  There have been a
> few low-level SMT changes I think.
> 
> Are you able to identify which kernel version broke it?

I do not have HT or SMP, though the kernel is smp. 2.6.9 works for me.
That's all I can tell now.


-- 
pozsy
