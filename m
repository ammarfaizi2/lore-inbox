Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266831AbRGHLQe>; Sun, 8 Jul 2001 07:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266833AbRGHLQZ>; Sun, 8 Jul 2001 07:16:25 -0400
Received: from borg.metroweb.co.za ([196.23.181.81]:13065 "EHLO
	borg.metroweb.co.za") by vger.kernel.org with ESMTP
	id <S266831AbRGHLQL>; Sun, 8 Jul 2001 07:16:11 -0400
From: Henry <henry@borg.metroweb.co.za>
To: Andrew Morton <andrewm@uow.edu.au>
Subject: Re: OOPS (kswapd) in 2.4.5 and 2.4.6
Date: Sun, 8 Jul 2001 13:08:22 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <01070516412506.06182@borg> <01070711384402.00793@borg> <3B46DC5C.76A3D7A5@uow.edu.au>
In-Reply-To: <3B46DC5C.76A3D7A5@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01070813155100.04666@borg>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> No, his oops was a bad inode state while trying to
> release unused NFS client inodes.  Different bug :)
> 

New development.  No oops, but apache eventually crashed with the same
error message 'semget - no space left on device'.  So,...  either this
was a coincidence (ie, with the kernel issue) and a problem exists with
Apache/1.3.19 Ben-SSL/1.42 (Unix)/PHP which requires a reboot to fix,
or something else is happening.  Could there be a link between the
previous kernel bug and the apache issue?  Do you have any idea what
the error message means, or what it's related to?  Previously (when the
oops was prevalent), the oops would occur at roughly the same time as
the apache problem - which could mean everything, or nothing at all...

sigh.

Cheers
Henry

