Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUEJWv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUEJWv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUEJWtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:49:49 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:17168 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262580AbUEJWrX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:47:23 -0400
To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace in 2.6.5
References: <1UlcA-6lq-9@gated-at.bofh.it>
	<m365b4kth8.fsf@averell.firstfloor.org>
	<1084220684.1798.3.camel@slack.domain.invalid>
	<877jvkx88r.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 11 May 2004 07:47:08 +0900
In-Reply-To: <877jvkx88r.fsf@devron.myhome.or.jp>
Message-ID: <873c67yk5v.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> So single-step exception happen *after* executed the "mov ...".
> Probably you need to use the breakpoint instead of single-step.

Ah, sorry. Just use PTRACE_SYSCALL instead of PTRACE_SINGLESTEP.
It's will stop before/after does syscall.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
