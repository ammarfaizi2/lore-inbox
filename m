Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264947AbTLWGV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 01:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbTLWGV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 01:21:27 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:42983 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264947AbTLWGV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 01:21:26 -0500
Message-ID: <007101c3c91d$5a8fe480$fd0eb609@srikrishnan>
From: "srikrish" <srikrish@in.ibm.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <anton@samba.org>
References: <004101c3c47c$114a32d0$0d0fb609@srikrishnan> <20031217010353.1fd32589.akpm@osdl.org>
Subject: Re: [PATCH] binfmt_elf.c SIGILL with large external static array on PPC64
Date: Tue, 23 Dec 2003 11:53:55 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
I found that Roland's patch addresses the issue in the same way that I had proposed. His patch looks fine. The return value of
set_brk function could be changed to unsigned long as do_brk returns unsigned long.

Srikrishnan

Andrew wrote:
>Yes.  I have queued up a patch for this from Roland Turner.  It is at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test10/2.6.0-test10-mm1/broken-out/fix-ELF-exec-with-huge-bss.patch

>Could you please review and test it?





