Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262986AbREWEac>; Wed, 23 May 2001 00:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262987AbREWEaX>; Wed, 23 May 2001 00:30:23 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:48816 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S262986AbREWEaD>; Wed, 23 May 2001 00:30:03 -0400
Message-ID: <3B0B3BAC.8B48E985@uow.edu.au>
Date: Wed, 23 May 2001 14:25:16 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (part 2) fs/super.c cleanups
In-Reply-To: <Pine.GSO.4.21.0105222256180.17373-100000@weyl.math.psu.edu> <Pine.GSO.4.21.0105222359430.17373-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
>         Locking rules: both require mount_sem and dcache_lock being
> held by callers.
>

It would help a lot if locking rules were commented in 
the source, rather than on linux-kernel.
