Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSFISFT>; Sun, 9 Jun 2002 14:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSFISD5>; Sun, 9 Jun 2002 14:03:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61531 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314381AbSFISCK>; Sun, 9 Jun 2002 14:02:10 -0400
To: Dave Jones <davej@suse.de>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: Re: [patch] fat/msdos/vfat crud removal
In-Reply-To: <87r8jhc685.fsf@devron.myhome.or.jp>
	<200206090709.g5979iK439624@saturn.cs.uml.edu>
	<20020609114638.J13140@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Jun 2002 11:52:28 -0600
Message-ID: <m18z5owd9f.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de> writes:

> On Sun, Jun 09, 2002 at 03:09:44AM -0400, Albert D. Cahalan wrote:
> 
>  > There has been talk of removing __KERNEL__ usage from
>  > some of the header files.
> 
> Where? If anything we need to increase __KERNEL__ usage in headers.
> We export far too much crap which makes no sense to userspace.

So we should just remove __KERNEL__ altogether.  And say with 2.5.x
nothing is exported.  Which pretty much has been the official policy
since user space started using glibc.

#include <linux/*>
and 
#include <asm/*>
are no longer supported.

Eric
