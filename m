Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbUAONNY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 08:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbUAONNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 08:13:24 -0500
Received: from mail3-126.ewetel.de ([212.6.122.126]:52632 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S266677AbUAONNJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 08:13:09 -0500
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stronger ELF sanity checks v2
In-Reply-To: <1eaqw-6Dk-29@gated-at.bofh.it>
References: <1dmam-2Xk-11@gated-at.bofh.it> <1dAQW-109-3@gated-at.bofh.it> <1dCSg-5vk-55@gated-at.bofh.it> <1eaqw-6Dk-29@gated-at.bofh.it>
Date: Thu, 15 Jan 2004 14:13:00 +0100
Message-Id: <E1Ah7Iy-0000NJ-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004 08:50:12 +0100, you wrote in linux.kernel:

> ld.so performs itself some tests, supplementing the tests in the kernel.
>  This is enough to catch ill-formed programs which might cause problems.

Not everybody is using glibc, ld.so implementations vary and it's
probable that not all do really check much.

I agree that the kernel should only check values that it really uses,
though. The other checks could be optional (CONFIG_WHATEVER) and/or
only lead to debugging messages if they fail.

-- 
Ciao,
Pascal
