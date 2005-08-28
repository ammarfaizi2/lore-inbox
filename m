Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVH1UhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVH1UhE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 16:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVH1UhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 16:37:04 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:35659 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750795AbVH1UhB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 16:37:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ERZ8YVgcX1JpEd5sZapL1dLHfYGA35pEluAwry7yV4Jt1MGWbOXcqfsKGV4hMSAEAHO7xBH7lNK5j6gi6FTCWU6eGs3cL5wNK8aMckJJdmQknlYIdFCW2p9X7KsqJdm5xsRMlVQWTyh9lbpEk7oQmZ6K7RjC8TYIIiO6YQawOns=
Message-ID: <7e5f607205082813366f6738d@mail.gmail.com>
Date: Sun, 28 Aug 2005 22:36:55 +0200
From: Peter Bortas <bortas@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.13-rc6-rt8
Cc: Peter Bortas <peter@bortas.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050823061445.GA30817@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050816121843.GA24308@elte.hu> <761x4s2uzg.fsf@bortas.org>
	 <20050823061445.GA30817@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/05, Ingo Molnar <mingo@elte.hu> wrote:
> 
> * Peter Bortas <peter@bortas.org> wrote:
> 
> > 2.6.13-rc6-rt8 fails to build with my configuration (attached):
> >
> > net/built-in.o: In function `ip_rt_init':
> > : undefined reference to `__you_cannot_kmalloc_that_much'
> > make[1]: *** [.tmp_vmlinux1] Error 1
> > make[1]: Leaving directory `/usr/src/linux-2.6.13-rc6'
> > make: *** [stamp-build] Error 2
> 
> ok, fixed the likely cause of this in -rt12. Could you check whether it
> builds for you now?
> 
>         Ingo

rc7-rt4 compiles fine now. 

(Sorry I missed your message when originally sent.)

-- 
Peter Bortas
