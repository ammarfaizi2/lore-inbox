Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270726AbTHFLsj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274859AbTHFLsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:48:39 -0400
Received: from dp.samba.org ([66.70.73.150]:5799 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270726AbTHFLsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:48:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16176.60080.922629.975916@cargo.ozlabs.ibm.com>
Date: Wed, 6 Aug 2003 21:46:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make mm4 compile on ppc
In-Reply-To: <20030805172314.0f2c0a5b.akpm@osdl.org>
References: <16176.18643.751075.223016@cargo.ozlabs.ibm.com>
	<20030805172314.0f2c0a5b.akpm@osdl.org>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Is current -linus OK?

Yes, it's fine.

I just tried -mm4 on my powerbook and it says it can't mount root,
although it says it is trying to mount hda11, which is correct.

> Yes, the dependency of vmlinux.lds.[so] on CONFIG_FOO has confused the heck
> out of kbuild.  Kai and Sam are working on it and patches are flying about.

Not sure I follow that - are you saying that the dependency on
asm_offsets.h was just to make it depend on some collection of headers
including config.h?

Paul.
