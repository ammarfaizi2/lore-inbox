Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272511AbTGaPLM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272509AbTGaPJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:09:44 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:52997 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S272508AbTGaPIW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:08:22 -0400
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Ren <l.s.r@web.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Inline vfat_strnicmp()
References: <20030727172150.15f8df7f.l.s.r@web.de>
	<200307311224.h6VCOMj19676@Port.imtp.ilyichevsk.odessa.ua>
	<87r846yfag.fsf@devron.myhome.or.jp>
	<200307311357.h6VDvEj20416@Port.imtp.ilyichevsk.odessa.ua>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 01 Aug 2003 00:07:58 +0900
In-Reply-To: <200307311357.h6VDvEj20416@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <87zniuwx81.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

> Yes, but some future version would.
> 
> Since there is no substantial wins in hunting down
> such statics, and there is some risk of code bloat when
> big inlined statics get called from more that one callsite,
> and it will be automatically handled by smarter compiler someday,
> I think it makes perfect sense to avoid doing this.

Could you tell me, if compiler does it in future? I'll gladly kill
that inline.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
