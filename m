Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVIZQoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVIZQoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbVIZQoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:44:44 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:54942 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751673AbVIZQon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:44:43 -0400
Subject: RE: Resource limits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roger Heflin <rheflin@atipa.com>
Cc: "'Al Boldi'" <a1426z@gawab.com>, linux-kernel@vger.kernel.org
In-Reply-To: <EXCHG2003ogxLDp7mvj00000ae4@EXCHG2003.microtech-ks.com>
References: <EXCHG2003ogxLDp7mvj00000ae4@EXCHG2003.microtech-ks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Sep 2005 18:11:30 +0100
Message-Id: <1127754691.27757.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-26 at 09:44 -0500, Roger Heflin wrote:
> While talking about limits, one of my customers report that if
> they set "ulimit -d" to be say 8GB, and then a program goes and

The kernel doesn't yet support rlimit64() - glibc does but it emulates
it best effort. Thats a good intro project for someone

> It would seem that the best thing to do would be to abort on
> allocates that will by themselves exceed the limit.

2.6 supports "no overcommit" modes.

Alan

