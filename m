Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267156AbUBSAGs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 19:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267158AbUBSAGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 19:06:48 -0500
Received: from mail1-106.ewetel.de ([212.6.122.106]:51400 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S267156AbUBSAGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 19:06:47 -0500
To: tridge@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <1qJsF-6Be-45@gated-at.bofh.it>
References: <1q4Si-658-5@gated-at.bofh.it> <1q7no-8ss-7@gated-at.bofh.it> <1qfb7-7s5-19@gated-at.bofh.it> <1qmPm-6Gl-11@gated-at.bofh.it> <1qpWI-1Sa-1@gated-at.bofh.it> <1qqpO-2lx-3@gated-at.bofh.it> <1qqzv-2tr-3@gated-at.bofh.it> <1qqJc-2A2-5@gated-at.bofh.it> <1qHAR-2Wm-49@gated-at.bofh.it> <1qIwr-5GB-11@gated-at.bofh.it> <1qIwr-5GB-9@gated-at.bofh.it> <1qIQ1-5WR-27@gated-at.bofh.it> <1qIZt-6b9-11@gated-at.bofh.it> <1qJsF-6Be-45@gated-at.bofh.it>
Date: Thu, 19 Feb 2004 01:06:35 +0100
Message-Id: <E1Atbi7-0004tf-O7@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 00:40:21 +0100, you wrote in linux.kernel:

> Because a large number of file operations are on filenames that don't
> exist. I have to *prove* they don't exist. That includes:

Evil question: do you need to be case-preserving? 'Cause if not, you
could simply squash all incoming filenames from case-insensitive clients
to some canonical form (say, all lower-case) and use that.

-- 
Ciao,
Pascal
