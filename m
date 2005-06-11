Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVFKUSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVFKUSn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 16:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVFKUSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 16:18:42 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:10969 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261815AbVFKUS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 16:18:29 -0400
Date: Sat, 11 Jun 2005 22:18:25 +0200
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Steve Lord <lord@xfs.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
Message-ID: <20050611201825.GA30006@ojjektum.uhulinux.hu>
References: <20050611120040.084942ed.akpm@osdl.org> <000a01c56ec1$75f437d0$6401a8c0@adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000a01c56ec1$75f437d0$6401a8c0@adic.com>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 03:09:08PM -0500, Steve Lord wrote:
> Well, the bizarre part is that I think this has been around for a while, 
> but it
> does not exhibit itself in redhat kernels which postdate the earliest
> recolloction of me seeing it. 2.6.11-rc1 is the earliest I remember,
> but I am not religious about updating the kernel on this box so
> my samples are spotty.
> 
> The difference between the two may be that I recompile for a P4
> while redhat uses a lowest common denominator cpu type.
> 
> If I get a chance this weekend I will try some other kernels and
> report back. Maybe just start out by dumbing down my cpu
> type.

I always used CONFIG_M586=y.

Did you turn preempt on? I did with the 2.6.12-rc, but not with the 
(working) 2.6.9, so this migth be the difference.
Sorry, I do not have currently for testing.


-- 
pozsy

