Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTJDOOQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 10:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbTJDOOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 10:14:16 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:39940 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S262052AbTJDOOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 10:14:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Andi Kleen <ak@suse.de>, <bvds@bvds.geneva.edu>
Subject: Re: segfault error on x86_64
Date: Sat, 4 Oct 2003 17:13:55 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <20031002215345.A1D33E24D6@bvds.geneva.edu.suse.lists.linux.kernel> <p73y8w2yboa.fsf@oldwotan.suse.de>
In-Reply-To: <p73y8w2yboa.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200310041713.55050.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 October 2003 11:20, Andi Kleen wrote:
> <bvds@bvds.geneva.edu> writes:
> > I have kernel 2.4.22 compiled with gcc 3.3 running on a
> > dual AMD Opteron (in 64 bit mode).
> > There is an error message that occurs about twice a day at random times:
> >
> > Sep 30 23:45:00 gideon kernel: bumps[12960]: segfault at 0000002a95611000
> > rip 0000000000402150 rsp 0000007fbffff1a8 error 6 Oct  1 10:26:57 gideon
> > kernel: bumps[13510]: segfault at 0000002a95611000 rip 0000000000402150
> > rsp 0000007fbffff1a8 error 6
> >
> > As far as I can tell, there is no other effect than this message.
> > (the system keeps running OK).
> >
> > What is "bumps" ?
>
> Some random program on your system. The x86-64 kernel logs all unhandled
> segfaults by default. It is unlikely to be a kernel problem.

Whoa. Do you mean it can be told to not do this?
This is very good, because it can now be generalized to all arches
without people objecting 'its legitimate to use unhandled SEGVs,
I do not want this logged' - they can turn it off in /proc.

Of course some folks will object anyway ;););)
-- 
vda
