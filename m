Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265252AbUD3URx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbUD3URx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUD3URx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:17:53 -0400
Received: from mail4-141.ewetel.de ([212.6.122.141]:50641 "EHLO
	mail4.ewetel.de") by vger.kernel.org with ESMTP id S265252AbUD3URv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:17:51 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible permissions bug on NFSv3 kernel client
In-Reply-To: <1Qrhg-5hH-29@gated-at.bofh.it>
References: <1QqNJ-4QH-37@gated-at.bofh.it> <1QqNJ-4QH-39@gated-at.bofh.it> <1QqNJ-4QH-35@gated-at.bofh.it> <1Qrhg-5hH-29@gated-at.bofh.it>
Date: Fri, 30 Apr 2004 22:17:47 +0200
Message-Id: <E1BJeSB-0000Gk-V2@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004 23:30:50 +0200, you wrote in linux.kernel:

> It's not "mixed up" at all: the permissions checking has to be done by
> the server, period.

Then it's at least inconsistent with local filesystem behaviour. fsck
has no problem opening device nodes for writing on my root filesystem
even though it is mounted read-only at that point.

-- 
Ciao,
Pascal
