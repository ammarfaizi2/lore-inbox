Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVJORxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVJORxR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 13:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVJORxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 13:53:17 -0400
Received: from [82.138.41.32] ([82.138.41.32]:56551 "EHLO foo.vault.bofh.ru")
	by vger.kernel.org with ESMTP id S1751188AbVJORxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 13:53:16 -0400
From: Serge Belyshev <belyshev@depni.sinp.msu.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: VFS: file-max limit 50044 reached
In-Reply-To: <87fyr2ape5.fsf@foo.vault.bofh.ru>
References: <87fyr2ape5.fsf@foo.vault.bofh.ru>
Date: Sat, 15 Oct 2005 21:53:14 +0400
Message-ID: <87slv23bw5.fsf@foo.vault.bofh.ru>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This problem was reproduced on i386 and amd64 with
>kernels 2.6.14-rc1 .. 2.6.14-rc4-git4

Caused by this change:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ab2af1f5005069321c5d130f09cce577b03f43ef
or
http://tinyurl.com/cyrou

aka "[PATCH] files: files struct with RCU"
