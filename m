Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbTLERaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbTLERaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:30:05 -0500
Received: from bay7-dav52.bay7.hotmail.com ([64.4.10.41]:14350 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264241AbTLER3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:29:53 -0500
X-Originating-IP: [24.61.138.213]
X-Originating-Email: [jason_kingsland@hotmail.com]
From: "Jason Kingsland" <Jason_Kingsland@hotmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>,
       "Kendall Bennett" <KendallB@scitechsoft.com>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312031533530.2055@home.osdl.org>
Subject: Re: Linux GPL and binary module exception clause?
Date: Fri, 5 Dec 2003 12:29:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <BAY7-DAV52PZku6s33Y00003c18@hotmail.com>
X-OriginalArrivalTime: 05 Dec 2003 17:29:52.0464 (UTC) FILETIME=[6439F500:01C3BB55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> There's a clarification that user-space programs that use the standard
> system call interfaces aren't considered derived works

If it said "user-space" or "non-kernel address space" in the Linux license
then I would agree.

But the exact wording is much more vague:

"user programs that use kernel services by normal system calls"

Any binary loadable kernel module can be considered a "user program"
Any interface defined in the kernel header files can be considered a "normal
system call"

This is why I think further clarification is warranted in future versions of
copying.txt - because we are needlessly giving away the source-code freedom
that GPL is intended to protect.

The proponents of binary-only kernel modules currently use the above as a
defense to argue their case for GPL non-compliance.
