Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUEOOam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUEOOam (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 10:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbUEOOam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 10:30:42 -0400
Received: from mail0-105.ewetel.de ([212.6.122.105]:19886 "EHLO
	mail0.ewetel.de") by vger.kernel.org with ESMTP id S262605AbUEOOal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 10:30:41 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS & long symlinks = stack overflow
In-Reply-To: <1W7S5-3Am-13@gated-at.bofh.it>
References: <1W7yE-3lZ-13@gated-at.bofh.it> <1W7S5-3Am-13@gated-at.bofh.it>
Date: Sat, 15 May 2004 16:30:28 +0200
Message-Id: <E1BP0BI-0000lo-09@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 May 2004 16:00:21 +0200, you wrote in linux.kernel:

> Lovely.  The real limit imposed by client (apparently not enforced, though)
> is PAGE_CACHE_SIZE - 4 - 1.  What are the protocol limits?

None. An NFSv3 server can enforce an arbitrary limit on filename length,
advertised via PATHCONF, though.

-- 
Ciao,
Pascal
