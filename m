Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270811AbTHAPs6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 11:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270813AbTHAPs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 11:48:57 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:8970 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270811AbTHAPsl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 11:48:41 -0400
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Ren <l.s.r@web.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Inline vfat_strnicmp()
References: <20030727172150.15f8df7f.l.s.r@web.de>
	<200307311357.h6VDvEj20416@Port.imtp.ilyichevsk.odessa.ua>
	<87zniuwx81.fsf@devron.myhome.or.jp>
	<200308010546.h715kJj24299@Port.imtp.ilyichevsk.odessa.ua>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 02 Aug 2003 00:47:45 +0900
In-Reply-To: <200308010546.h715kJj24299@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <87lludv0pq.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

> I can't be 100.00% sure it will happen. I'd say 98.234235% ;)
> 
> Andrew Morton kills extra large inlines, and you are creating them :(
> That's not ok. Just leave those poor static functions alone
> until compiler will do them, all at once.
> There are lots of other stuff to do in the kernel source.

 - That's smaller than prev in *real world*.
 - You don't fix compiler.

End of story.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
