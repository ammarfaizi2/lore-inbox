Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310326AbSCBGSu>; Sat, 2 Mar 2002 01:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310328AbSCBGSb>; Sat, 2 Mar 2002 01:18:31 -0500
Received: from 1Cust55.tnt6.lax7.da.uu.net ([67.193.244.55]:5624 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S310326AbSCBGS3>; Sat, 2 Mar 2002 01:18:29 -0500
Subject: Re: dell inspiron and 2.4.18?
To: jjasen1@umbc.edu (John Jasen)
Date: Fri, 1 Mar 2002 22:19:59 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.31L.02.0203020004440.5865235-100000@irix2.gl.umbc.edu> from "John Jasen" at Mar 02, 2002 12:11:45 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020302061959.383EE89C87@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Jasen wrote:
> I have a Dell Inspiron 3700 running Redhat 7.2 with the latest updates,
> and I just upgraded to kernel 2.4.18. On random intervals, usually within
> about 10 minutes of usage, it hangs completely solid.
[snip]
> Anyway, the short form: anyone else have any problems, or have I gone
> crazy again?

My own Inspiron 5000e is running a heavily patched-up (-jam with
grsecurity and a few other things merged in) 2.4.18-based kernel with no
problems.

I installed 2.4.18-ac2 on an Inspiron 7500 today, and rpm started
corrupting its database repeatedly (rpm --rebuilddb would only fix things
until I installed or freshened a few more packages, then the corruption
would come back). Upgrading rpm to the 4.0.3 release candidate from
Rawhide, then doing another rpm --rebuilddb to be safe, made this problem
completely disappear however, and the system is otherwise totally stable
so far.

-Barry K. Nathan <barryn@pobox.com>
