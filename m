Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUEAKzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUEAKzC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 06:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUEAKzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 06:55:02 -0400
Received: from mail4-141.ewetel.de ([212.6.122.141]:11939 "EHLO
	mail4.ewetel.de") by vger.kernel.org with ESMTP id S261389AbUEAKzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 06:55:00 -0400
Date: Sat, 1 May 2004 12:54:52 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: Possible permissions bug on NFSv3 kernel client
In-Reply-To: <1083357597.13656.37.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.58.0405011240420.231@neptune.local>
References: <1QqNJ-4QH-37@gated-at.bofh.it> <1QqNJ-4QH-39@gated-at.bofh.it>
  <1QqNJ-4QH-35@gated-at.bofh.it> <1Qrhg-5hH-29@gated-at.bofh.it> 
 <E1BJeSB-0000Gk-V2@localhost> <1083357597.13656.37.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Trond Myklebust wrote:

> So why do you think that is inconsistent with my statement: "the
> permissions checking has to be done by the server, period"?

I see it wasn't clear from my reply. I don't disagree at all.
Permission checking is the server's job. Clients are untrusted.

> This should be entirely consistent with local file behaviour.
> Particularly since the code to deal with the read-only mount option in
> nfs_permission() was pretty much cut-n-pasted from vfs_permission().

The original poster said it didn't work for him on an NFSv3 mount.
Looking at nfs_permission() I (of course) agree it looks innocent
enough.

-- 
Ciao,
Pascal
