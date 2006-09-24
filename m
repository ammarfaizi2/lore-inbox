Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWIXN3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWIXN3q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 09:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWIXN3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 09:29:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49851 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750766AbWIXN3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 09:29:45 -0400
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45162BE5.2020100@aknet.ru>
References: <45150CD7.4010708@aknet.ru>
	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
	 <451555CB.5010006@aknet.ru>
	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>
	 <1159037913.24572.62.camel@localhost.localdomain>
	 <45162BE5.2020100@aknet.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 24 Sep 2006 14:53:52 +0100
Message-Id: <1159106032.11049.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-09-24 am 10:55 +0400, ysgrifennodd Stas Sergeev:
> Before, people could use it and hope the binaries
> won't get executed (and if it was possible to execute
> them by invoking ld.so directly, then ld.so could have
> been fixed). Now the only possibility is to not use the
> "noexec" at all.
> So does that add to security or substract?..

If you want a tmpfs with noexec and a shared memory space with exec why
don't you just sort out mounting two different tmpfs instances ?

Alan

