Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136818AbREIScp>; Wed, 9 May 2001 14:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136819AbREIScg>; Wed, 9 May 2001 14:32:36 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:52131 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id <S136818AbREISc2>;
	Wed, 9 May 2001 14:32:28 -0400
Date: Wed, 9 May 2001 11:32:18 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: =?iso-8859-1?q?Mart=EDn=20Marqu=E9s?= <martin@bugs.unl.edu.ar>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <01050910381407.26653@bugs>
Message-ID: <Pine.LNX.4.33.0105091115390.10249-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a proxy server that's been running 2.4.3pre4 with reiserfs for the
partitions on the cache disks. it has an uptime of 43 days at this point.
it wasn't very stable at all (two crashes in one week) with 2.4.2. I'll be
building 2.4.4 something when I get back from ghana to the US, but I don't
want to reboot it onto a fresh kernel while I'm 11,000 miles away, serial
console notwithstanding.

Overall I'm of the belief that reiserfs is robust enough for mainstream
use, and it's significantly faster than ext2 for the squid box, you do as
usal need to be a bit selective about what kernel you choose to run.

On Wed, 9 May 2001, Martín Marqués wrote:

> Hi,
>
> We are waiting for a server with dual PIII, RAID 1,0 and 5 18Gb scsi disks to
> come so we can change our proxy server, that will run on Linux with Squid.
> One disk will go inside (I think?) and the other 4 on a tower conected to the
> RAID, which will be have the cache of the squid server.
>
> One of my partners thinks that we should use reiserfs on all the server (the
> partitions of the Linux distro, and the cache partitions), and I found out
> that reiserfs has had lots of bugs, and is marked as experimental in kernel
> 2.4.4. Not to mention that the people of RH discourage there users from using
> it.
>
> There has also been lots of talks about reiserfs being the cause of some data
> lose and performance lose (not sure about this last one).
>
> So what I want is to know which is the status of this 3 journaling FS. Which
> is the one we should look for?
>
> I think that the data lose is not significant in a proxy cache, if the FS is
> really fast, as is said reiserfs is.
>
> Saludos... :-)
>
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


