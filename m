Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135427AbRECXow>; Thu, 3 May 2001 19:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135443AbRECXom>; Thu, 3 May 2001 19:44:42 -0400
Received: from mail2.mia.bellsouth.net ([205.152.144.14]:44522 "EHLO
	mail2.mia.bellsouth.net") by vger.kernel.org with ESMTP
	id <S135427AbRECXoe>; Thu, 3 May 2001 19:44:34 -0400
Message-ID: <3AF1E2BD.99516FBE@bellsouth.net>
Date: Thu, 03 May 2001 18:59:09 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@nl.linux.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: <20010503211046Z92199-3530+25@humbolt.nl.linux.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works fine now.  I'll keep on testing.
Thanks a bunch,
Albert
Daniel Phillips wrote:
> 
> > This combination against 2.4.4 won't allow directories to be moved.
> > Ex: mv a b #fails with I/O error.  See attached strace.
> > But with ext2-dir-patch-S4 by itself, mv works as it should.
> 
> Now it also works with my index patch as it should:
> 
>     http://nl.linux.org/~phillips/htree/dx.pcache-2.4.4-3
> 

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
