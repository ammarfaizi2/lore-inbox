Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUK3XBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUK3XBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbUK3W7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:59:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:11421 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262405AbUK3W5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:57:17 -0500
Date: Tue, 30 Nov 2004 15:01:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: s390 patches for -bk.
Message-Id: <20041130150131.2f955be9.akpm@osdl.org>
In-Reply-To: <20041130150817.GA4758@mschwid3.boeblingen.de.ibm.com>
References: <20041130150817.GA4758@mschwid3.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> Hi Andrew,
> another update for s390. This is the last patch-set from me for this
> year. I asked Heiko Carstens (heiko.carstens@de.ibm.com) to keep an
> eye on Bitkeeper for the next few weeks. If anything breaks he'll post
> patches to keep s390 working.
> 
> The patches:
> 1) s390 core fixes
> 2) common i/o layer bug fixes
> 3) dcss segment interface changes
> 4) dasd driver fixes
> 5) z/VM monitor stream change

Do you think these should be in 2.6.10?

> 6) qeth network driver fixes. This patch depends on the last s390
>    networking patch (s390-network-driver-patch in 2.6.10-rc2-mm4)
>    which is pending because of the discussion about whether to drop
>    network packets on a link failure or not. Thomas said that the
>    discussion will take some more time.

OK.  I'll assume that this discussion is actually proceeding somewhere -
otherwise it will take a lot more time ;)

