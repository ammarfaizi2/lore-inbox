Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWIWPp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWIWPp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWIWPp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:45:59 -0400
Received: from mail.aknet.ru ([82.179.72.26]:263 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751258AbWIWPp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:45:58 -0400
Message-ID: <45155707.4010906@aknet.ru>
Date: Sat, 23 Sep 2006 19:47:19 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru> <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com> <45155499.4000209@redhat.com>
In-Reply-To: <45155499.4000209@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Ulrich Drepper wrote:
> Definitely not.  The test should stay.  It does the right thing.  Yes,
> some applications might break, but this is the fault of the application.
But why exactly? They do:
shm_open();
mmap(PROT_READ|PROT_WRITE|PROT_EXEC);
and mmap fails.
Where is the fault of an app here?

