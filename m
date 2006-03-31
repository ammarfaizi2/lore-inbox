Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWCaRTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWCaRTS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWCaRTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:19:17 -0500
Received: from mail.parknet.jp ([210.171.160.80]:45575 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1750942AbWCaRTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:19:16 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andi Kleen <ak@suse.de>
Cc: Jes Sorensen <jes@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] avoid unaligned access when accessing poll stack
References: <yq0sloytyj5.fsf@jaguar.mkp.net>
	<87irpupo3y.fsf@duaron.myhome.or.jp> <200603311853.32870.ak@suse.de>
	<87ek0ipmae.fsf@duaron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 01 Apr 2006 02:19:12 +0900
In-Reply-To: <87ek0ipmae.fsf@duaron.myhome.or.jp> (OGAWA Hirofumi's message of "Sat, 01 Apr 2006 02:16:25 +0900")
Message-ID: <87wteao7lb.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> 	char stack_pps[POLL_STACK_ALLOC]
>         	__attribute__((aligned (sizeof(struct poll_list))));

Ugh, just wrong. Please ignore.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
