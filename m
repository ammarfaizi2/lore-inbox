Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287933AbSABTvk>; Wed, 2 Jan 2002 14:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287919AbSABTva>; Wed, 2 Jan 2002 14:51:30 -0500
Received: from svr3.applink.net ([206.50.88.3]:32518 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287933AbSABTvU>;
	Wed, 2 Jan 2002 14:51:20 -0500
Message-Id: <200201021951.g02JpCSr021687@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: timothy.covell@ashavan.org, adrian kok <adriankok2000@yahoo.com.hk>,
        linux-kernel@vger.kernel.org
Subject: How can one get System.map w/o vmlinux?
Date: Wed, 2 Jan 2002 13:47:29 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201021930.g02JUCSr021556@svr3.applink.net>
In-Reply-To: <200201021930.g02JUCSr021556@svr3.applink.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The System.map question brings up several more:

1. Is it correct to say that System.map is basically
the software interrupt table? ( and that for Linux
software Interrupts equal syscalls)

2. If one doesn't have vmlinux lying around, is there
an easy way to recreate this (via a syscall or small
SUID root C program to dump out the vectors)

3. Wouldn't it be a good idea to allow for System.map
to be handled automagically like Lilo and Grub handle
different kernels?  If only to avoid this confusion and
those pesky "ps" warnings.

4. Why does "ps" really care about System.map?


-- 
timothy.covell@ashavan.org.
