Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289663AbSAJUnV>; Thu, 10 Jan 2002 15:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289661AbSAJUnM>; Thu, 10 Jan 2002 15:43:12 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:3695 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289663AbSAJUnA>; Thu, 10 Jan 2002 15:43:00 -0500
Date: Thu, 10 Jan 2002 15:42:58 -0500 (EST)
From: Peter Jones <pjones@redhat.com>
X-X-Sender: <pjones@devserv.devel.redhat.com>
To: Dave Jones <davej@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] #ifdef __cplusplus removal (fwd)
In-Reply-To: <Pine.LNX.4.33.0201102139390.9236-100000@wotan.suse.de>
Message-ID: <Pine.LNX.4.33.0201101541390.7586-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Dave Jones wrote:

> On Thu, 10 Jan 2002, Peter Jones wrote:
> 
> >  And again for my bad email aliases :)
> > This patch removes the "#ifdef __cplusplus" from within a "#ifdef
> > __KERNEL__" in linux/string.h.  It really isn't needed AFACIT.  It was
> > put
> > in for 1.1.0, which was before __KERNEL__ appeared.  Alan told me to
> > send it to you.
> 
> A quick grep shows __cplusplus is used in quite a few places in the kernel
> source. I'm wondering if various developers are running their code through
> g++ to maybe pick up on warnings that gcc doesn't see.

That was the only one I saw in include/linux that was inside __KERNEL__ .  

I didn't look in include/asm* carefully, but grep found some __cplusplus 
code there as well.

-- 
        Peter

