Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129641AbRAMVBS>; Sat, 13 Jan 2001 16:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbRAMVBI>; Sat, 13 Jan 2001 16:01:08 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:52725 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129641AbRAMVA6>; Sat, 13 Jan 2001 16:00:58 -0500
Date: Sat, 13 Jan 2001 12:58:36 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: shmem or swapfs? was: [Patch] make shm filesystem part configurable
To: linux-kernel@vger.kernel.org, cr@sap.com
Reply-to: dank@alumni.caltech.edu
Message-id: <3A60C17C.3929E3F6@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan (acahalan@cs.uml.edu) wrote:
> Christoph Rohland writes: 
> > I am quite open about naming, but "shm" is not appropriate any more 
> > since the fs does a lot more than shared memory. Solaris calles this 
> > "tmpfs" but I did not want to 'steal' their name and I also do not 
> > think that it's a very good name. 
> 
> Admins already know what "tmpfs" means, so you should just call 
> your filesystem that. I know it isn't a pretty name, but in the 
> interest of reducing confusion, you should use the existing name. 
> 
> Don't think of it as just "for /tmp". It is for temporary storage. 
> The name is a reminder that you shouldn't store archives in tmpfs. 
> 
> Again for compatibility, Sun's size option would be useful. 

I agree with Albert; if it does the same thing as Sun's tmpfs,
let's call it tmpfs, and use the same options.

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
