Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSGGWqv>; Sun, 7 Jul 2002 18:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSGGWqu>; Sun, 7 Jul 2002 18:46:50 -0400
Received: from [209.184.141.189] ([209.184.141.189]:12524 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S316608AbSGGWqt>;
	Sun, 7 Jul 2002 18:46:49 -0400
Subject: Re: Reg. segmentation fault on sparc with gcc-3.0 (ld)
From: Austin Gonyou <austin@digitalroadkill.net>
To: Shanti Katta <katta@csee.wvu.edu>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1026081797.7057.10.camel@indus>
References: <1026081797.7057.10.camel@indus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 07 Jul 2002 17:49:22 -0500
Message-Id: <1026082162.11740.1.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would have to recommend you try 3.1. I've had issues compiling lots of
stuff with 3.0, until 3.0.4, but still 3.1 has been much better. The
issues were just odd, and I can't really say what fixed them exactly,
but rebuilding problematic programs, with gcc 3.1, made my problems go
away. Usual things were spurious segfaults for no apparent reason. GDB
couldn't even help, not really.

On Sun, 2002-07-07 at 17:43, Shanti Katta wrote:
> Hi,
> When I try to compile user-mode-linux on UltraSparc-I, I get the
> following error message during linking:
> 
> gcc-3.0 -o mk_task mk_task_user.o mk_task_kern.o
> collect2: ld terminated with signal 11 [Segmentation fault], core dumped
> 
> I could not get any help regarding this error on the web. Is it because
> of some sparc 32/64 oddities or it has something to do with the
> compiler?
> 
> Any pointers will be appreciated
> 
> Thank you,
> -Regards
> -Shanti
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
