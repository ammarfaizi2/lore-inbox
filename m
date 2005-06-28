Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVF1VCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVF1VCe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVF1VC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:02:27 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:900
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261422AbVF1VCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:02:04 -0400
Date: Tue, 28 Jun 2005 14:01:36 -0700 (PDT)
Message-Id: <20050628.140136.57453291.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Subject: recent kprobe work
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can the folks submitting all of the kprobe stuff at least consult me
when they can't figure out how to implement the sparc64 kprobe variant
for new features?

Currently, the sparc64 build is broken by recent kprobe
changes:

kernel/built-in.o: In function `init_kprobes':
: undefined reference to `arch_init'

Also, can we use a more namespace friendly name for this kprobe layer
specific function other than "arch_init()"?

Thanks.
