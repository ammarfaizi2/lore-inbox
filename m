Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbSKSSR1>; Tue, 19 Nov 2002 13:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbSKSSR1>; Tue, 19 Nov 2002 13:17:27 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:31170 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267068AbSKSSRZ>; Tue, 19 Nov 2002 13:17:25 -0500
Date: Tue, 19 Nov 2002 10:17:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andy Pfiffer <andyp@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7 -- Success Story!
Message-ID: <4090000.1037729868@flay>
In-Reply-To: <m1adk51n0e.fsf@frodo.biederman.org>
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com><m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp><m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp><m1k7jb3flo.fsf_-_@frodo.biederman.org><m1el9j2zwb.fsf@frodo.biederman.org><m11y5j2r9t.fsf_-_@frodo.biederman.org><1037668241.10400.48.camel@andyp> <m1isyt26wr.fsf@frodo.biederman.org><1037726468.10400.81.camel@andyp> <m1adk51n0e.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Just to make sure I understand the problem.  Until we can make all
>> boot-time BIOS calls work, we need a way to:
> 
> A small clarification.  BIOS calls will never work 100%.  Especially in the
> interesting cases like kexec on panic.  So entering the kernel in
> 32bit mode will continue to be the default mode of.  This means the
> final solution to problems like this needs to be a good one.

Do we still have the mpstables and other such initdata around as well?
Or did we destroy those on boot? If we're going to do kexec on panic,
perhaps all these should be checksummed for corruption detection 
eventually (not now).

M.

