Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTFOVHC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 17:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTFOVHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 17:07:02 -0400
Received: from mail2.ewetel.de ([212.6.122.18]:1993 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S262861AbTFOVHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 17:07:01 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make cramfs look less hostile
In-Reply-To: <20030615183011$3fc0@gated-at.bofh.it>
References: <20030615161009$6dde@gated-at.bofh.it> <20030615174004$76d0@gated-at.bofh.it> <20030615175007$7f59@gated-at.bofh.it> <20030615175012$0573@gated-at.bofh.it> <20030615181004$3663@gated-at.bofh.it> <20030615181010$7f10@gated-at.bofh.it> <20030615182013$7a4e@gated-at.bofh.it> <20030615183011$3fc0@gated-at.bofh.it>
Date: Sun, 15 Jun 2003 23:20:19 +0200
Message-Id: <E19RevD-0000jc-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jun 2003 20:30:11 +0200, you wrote in linux.kernel:

> The only places where this should happen is mounting the rootfs.
> mount(8) has it's own filesystem type detection code and doesn't
> call mount(2) unless it found a matching filesystem type.

Not everybody uses mount(8) from util-linux... I don't think the
more simplicistic versions in embedded systems will even want to
do their own type detection. ;)

-- 
Ciao,
Pascal
