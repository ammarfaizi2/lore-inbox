Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266895AbUHITMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266895AbUHITMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266900AbUHITKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:10:01 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:8970 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266895AbUHIS73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:59:29 -0400
To: "John Stoffel" <stoffel@lucent.com>
Cc: Harald Arnesen <harald@skogtun.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-bk13 and later: Read-only filesystem on USB
References: <87n01944xd.fsf@basilikum.skogtun.org>
	<16659.38405.356084.360627@gargle.gargle.HOWL>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 10 Aug 2004 03:58:31 +0900
In-Reply-To: <16659.38405.356084.360627@gargle.gargle.HOWL>
Message-ID: <87d620p294.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John Stoffel" <stoffel@lucent.com> writes:

> Finally, the damm thing is mounted RW and actually lets me write
> something to the goddamm thing.  
> 
> What a pain in the ass.  This change should be reverted until it's
> properly implemented to tell mount(8) that it's not mounted RW, but RO
> instead.

The kernel is already exporting the some information. cat /proc/mounts.

Yes, probably proper interface would be useful. But it's the another
story.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
