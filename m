Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285812AbRLYU1e>; Tue, 25 Dec 2001 15:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285841AbRLYU1O>; Tue, 25 Dec 2001 15:27:14 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:41744 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S285812AbRLYU1I>; Tue, 25 Dec 2001 15:27:08 -0500
Message-ID: <000701c18d82$57158ea0$0801a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: <linux-kernel@vger.kernel.org>, <netfilter-devel@lists.samba.org>
Subject: file names ?
Date: Tue, 25 Dec 2001 20:25:48 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

i could not help but notice in the kernel source
in both the ipv4/netfilter and ipv6/netfilter
dirs there are files the same name which can cause problems
under certin conditions like non-case sensitive file systems.

like
ipt_mark.c
ipt_MARK.c

ipt_tos.c
ipt_TOS.c

this does not cause a problem for me but i do
know people who it does cause a problem for

a small example is a smallish ext2 / filesystem
and the rest being a fat filesystem to that
it can be accessed from both windows and linux.
and there is not enough space on the ext2 to compile a kernel anymore.

anyone got any suggestions ?

thanks
    James

--------------------------
Mobile: +44 07779080838
http://www.stev.org
  8:10pm  up 7 days,  3:40,  1 user,  load average: 0.00, 0.00, 0.00



