Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132167AbRCVTk1>; Thu, 22 Mar 2001 14:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132156AbRCVTkS>; Thu, 22 Mar 2001 14:40:18 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:42993 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S132171AbRCVTkG>; Thu, 22 Mar 2001 14:40:06 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, nfs-devel@linux.kernel.org
Subject: Re: PROBLEM: 2.2.18 oops leaves umount hung in disk sleep
In-Reply-To: <E14g8eP-0006k5-00@intech19.enhanced.com> <shs1yrpabky.fsf@charged.uio.no>
From: Camm Maguire <camm@enhanced.com>
Date: 22 Mar 2001 14:39:10 -0500
In-Reply-To: Trond Myklebust's message of "22 Mar 2001 19:43:41 +0100"
Message-ID: <54hf0l8ug1.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, and thanks for your reply!

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> >>>>> " " == Camm Maguire <camm@enhanced.com> writes:
> 
>      > 2.2.18 oops leaves umount hung in disk sleep
> 
> This is normal behaviour for an Oops ;-)
> 
>      >      Unable to handle kernel NULL pointer dereference at
>      >      virtual address 00000000
>     current-> tss.cr3 = 02872000, %%cr3 = 02872000
>      >      *pde = 00000000 Oops: 0000 CPU: 0
> 
>      >      intech9# ksymoops <oo.txt
> 
>      >      Unable to handle kernel NULL pointer dereference at
>      >      virtual address 00000000 current->tss.cr3 = 02872000,
>      >      %%cr3 = 02872000 *pde = 00000000 Oops: 0000 CPU: 0
> 
> Do you have the full ksymoops decode available? The above is somewhat
> minimal.
> 

I'd be happy to generate one if I could.  I've got the system map.
The defaults reported by ksymoops are all correct.  Don't know why it
didn't give me more info.  Normally, the info is reported by klogd
anyway, but not here.  I've sent you all I currently have.  If you can
suggest how I can get more, would be glad to do so.

Take care,

> Also please could you try to duplicate the problem with a standard
> autofs v3 daemon? I'm not sure that the v4 'automount' is quite as
> well tested as the v3 daemon (it still seems to be in beta).
> 

I thought I was running v3.  Can't seem to find anything now which
indicates the protocol version in use, but was under the impression
that v4 was only an option in 2.4.x, no?  

Also, the system is in general *very* stable.  It will take quite a
while for this to resurface, I'd guess.

Take care,

> Cheers,
>   Trond
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
