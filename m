Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292879AbSCAW3X>; Fri, 1 Mar 2002 17:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293047AbSCAW3P>; Fri, 1 Mar 2002 17:29:15 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:54484 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S292879AbSCAW3F>; Fri, 1 Mar 2002 17:29:05 -0500
Date: Fri, 1 Mar 2002 16:28:56 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] #define yield() for 2.4 scheduler (anticipating O(1))
Message-ID: <20020301162856.A14210@asooo.flowerfire.com>
In-Reply-To: <20020301163237.GC16716@opeth.ath.cx> <20020301185825.GK2711@matchmail.com> <1015017496.2325.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1015017496.2325.7.camel@localhost.localdomain>; from bonganilinux@mweb.co.za on Fri, Mar 01, 2002 at 11:18:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I doubt this is an issue specific to the kernel or patches -- I've had
O(1) running with -aa and -rmap for quite some time with no problems.  I
was recoding rather than implementing the macro, but the concept was the
same.

-- 
Ken.
brownfld@irridia.com

On Fri, Mar 01, 2002 at 11:18:12PM +0200, Bongani Hlope wrote:
| I once tried to apply the O(1) scheduler on 2.4.18-pre9 + aa vm and I
| made a similar change (the O(1) patch was rejected on buffer.c) and it
| caused so corruption on my file system (ext2), but I'm still not sure
| what cause it that change was my main concern. I think Ingo is using
| sys_sched_yield(); instead of yield. I will still be carefull about it
| though.
