Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272500AbTGaPCA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272504AbTGaPCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:02:00 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:46085 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S272500AbTGaPB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:01:59 -0400
To: David Weinehall <tao@acc.umu.se>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Ren <l.s.r@web.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Inline vfat_strnicmp()
References: <20030727172150.15f8df7f.l.s.r@web.de>
	<87wue4udxl.fsf@devron.myhome.or.jp>
	<200307311224.h6VCOMj19676@Port.imtp.ilyichevsk.odessa.ua>
	<87r846yfag.fsf@devron.myhome.or.jp>
	<20030731140442.GE16315@khan.acc.umu.se>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 01 Aug 2003 00:00:36 +0900
In-Reply-To: <20030731140442.GE16315@khan.acc.umu.se>
Message-ID: <874r12yc4r.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall <tao@acc.umu.se> writes:

> And how big is the performance loss?  Is it even measurable?
> And even if it is, is optimizing this really worth the trouble?

48bytes smaller than prev. I think It's not a clear reason for
rejecting a patch.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
