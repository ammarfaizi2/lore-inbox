Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263797AbREYQpD>; Fri, 25 May 2001 12:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263803AbREYQox>; Fri, 25 May 2001 12:44:53 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:63109 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id <S263798AbREYQon>;
	Fri, 25 May 2001 12:44:43 -0400
Date: Fri, 25 May 2001 09:44:36 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Greg Johnson <gjohnson@research.canon.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Big-ish SCSI disks
In-Reply-To: <20010525000502.B998037530@zapff.research.canon.com.au>
Message-ID: <Pine.LNX.4.33.0105250941110.20171-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

75GB 80GB 180GB all work fine...

your issues are:

location of kernel, below 8GB until you have the chance to turn on lba32
in your lilo.conf...

2GB  filesize limit bites people who use large disks more often (well at
least in my app), use reiserfs.

joelja

On Fri, 25 May 2001, Greg Johnson wrote:

> Hi kernel poeple,
>
> Can anyone out there say for certain that 76GB SCSI disks should
> just work with kernel versions 2.2 and/or 2.4? We need to get some
> big disk space and have heard reports of problems with disks
> bigger than 30GB under linux.
>
> Thanks.
>
> Greg.
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


