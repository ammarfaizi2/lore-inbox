Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbUKIRfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbUKIRfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 12:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbUKIRfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 12:35:11 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:37390 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261593AbUKIRfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 12:35:07 -0500
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Return better error codes from
 vfat_valid_longname()
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
	<20041109013848.GC6835@neapel230.server4you.de>
	<87vfcf3uu0.fsf@devron.myhome.or.jp>
	<20041109164902.GA14088@neapel230.server4you.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 10 Nov 2004 02:35:00 +0900
In-Reply-To: <20041109164902.GA14088@neapel230.server4you.de> (Rene
 Scharfe's message of "Tue, 9 Nov 2004 17:49:02 +0100")
Message-ID: <87bre7j58b.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> At least ENAMETOOLONG and ENOENT are properly defined error codes. :)

Ah, yes. IIRC I already fixed the ENOENT case.
We shouldn't need "len == 0" check, right?

> Anyway, what do you think about the following patch? I just replaced
> EACCES by EINVAL.

Looks good.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
