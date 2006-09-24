Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWIXRDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWIXRDA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 13:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWIXRDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 13:03:00 -0400
Received: from mail.aknet.ru ([82.179.72.26]:52229 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751165AbWIXRC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 13:02:59 -0400
Message-ID: <4516BA95.6030900@aknet.ru>
Date: Sun, 24 Sep 2006 21:04:21 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru> <1159106032.11049.12.camel@localhost.localdomain> <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com> <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>
In-Reply-To: <4516B721.5070801@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Ulrich Drepper wrote:
> The consensus has been to add the same checks to mprotect.  They were
> not left out intentionally.
I know, and as long as the mmap have these checks,
that would be at least consistent.
But could you please explain what does that solve
*besides* the ld.so problem, which looks like the
user-space problem to me? I tried my best to express
the negative sides of that approach, but what are
the positive ones?
If that approach forces people to avoid using "noexec"
where they previously used it for good, then I'd even
call it a regression.

