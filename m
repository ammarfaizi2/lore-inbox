Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbQKRUna>; Sat, 18 Nov 2000 15:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131192AbQKRUnU>; Sat, 18 Nov 2000 15:43:20 -0500
Received: from hermes.mixx.net ([212.84.196.2]:18190 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130516AbQKRUnL>;
	Sat, 18 Nov 2000 15:43:11 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
Date: Sat, 18 Nov 2000 21:13:26 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A16E2E6.4978A7A4@innominate.de>
In-Reply-To: <200011141459.IAA413471@tomcat.admin.navo.hpc.mil> <3A117311.8DC02909@holly-springs.nc.us> <news2mail-3A15ACE3.5BED2CA3@innominate.de> <m1u2965c4t.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 974578389 14822 10.0.0.90 (18 Nov 2000 20:13:09 GMT)
X-Complaints-To: news@innominate.de
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Daniel Phillips <news-innominate.list.linux.kernel@innominate.de> writes:
> 
> > Actually, I was planning on doing on putting in a hack to do something
> > like that: calculate a checksum after every buffer data update and check
> > it after write completion, to make sure nothing scribbled in the buffer
> > in the interim.  This would also pick up some bad memory problems.
> 
> Be very careful that this just applies to metadata.  For normal data
> this is a valid case.  Weird but valid.

I'm not sure what you mean.  With the exception of mmap'd files, the
filesystem (or VFS) controls every transfer onto a buffer so... what
does that leave?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
