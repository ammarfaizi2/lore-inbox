Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbTDUViD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbTDUViC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:38:02 -0400
Received: from hera.cwi.nl ([192.16.191.8]:44763 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262649AbTDUVgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:36:00 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 21 Apr 2003 23:48:01 +0200 (MEST)
Message-Id: <UTC200304212148.h3LLm1G05835.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, davem@redhat.com, hch@infradead.org,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       viro@parcelfarce.linux.theplanet.co.uk, zippel@linux-m68k.org
Subject: Re: [PATCH] new system call mknod64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's go for 32:32 internal and simply map upon mknod(2) and friends.
> On the syscall boundary.  End of problem.

Yes. I hope you don't mind that I called this 32:32 monster kdev_t.
