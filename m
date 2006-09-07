Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWIGJmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWIGJmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 05:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWIGJmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 05:42:40 -0400
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:20696 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1751267AbWIGJmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 05:42:39 -0400
Date: Thu, 07 Sep 2006 18:42:35 +0900 (JST)
Message-Id: <20060907.184235.15248417.nemoto@toshiba-tops.co.jp>
To: schwab@suse.de
Cc: jakub@redhat.com, sebastien.dugue@bull.net, arjan@infradead.org,
       mingo@redhat.com, linux-kernel@vger.kernel.org, pierre.peiffer@bull.net,
       drepper@redhat.com
Subject: Re: NPTL mutex and the scheduling priority
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <je7j0grp8t.fsf@sykes.suse.de>
References: <20060907083244.GA12531@devserv.devel.redhat.com>
	<20060907.183013.55145698.nemoto@toshiba-tops.co.jp>
	<je7j0grp8t.fsf@sykes.suse.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2006 11:37:54 +0200, Andreas Schwab <schwab@suse.de> wrote:
> > And ENOTSUP is not enumerated in ERRORS section of pthread_mutex_init.
> 
> POSIX does not forbid additional error conditions, as long as the
> described conditions are properly reported with the documented error
> numbers.

Oh, I see the point.  Thank you.

---
Atsushi Nemoto
