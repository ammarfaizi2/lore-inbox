Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWIWSef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWIWSef (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 14:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWIWSef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 14:34:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38876 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751412AbWIWSee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 14:34:34 -0400
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Stas Sergeev <stsp@aknet.ru>, Andrew Morton <akpm@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>
References: <45150CD7.4010708@aknet.ru>
	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
	 <451555CB.5010006@aknet.ru>
	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 23 Sep 2006 19:58:33 +0100
Message-Id: <1159037913.24572.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-23 am 17:04 +0100, ysgrifennodd Hugh Dickins:
> No, it's not.  But this doesn't have much to do with tmpfs,
> nor with shm_open.  It's just that the kernel is not allowing
> mmap PROT_EXEC on a MNT_NOEXEC mount.  Which seems reasonable
> (though you can argue that mprotect ought to disallow it too).

Agreed mprotect should also be fixed.


