Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbUEDX6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUEDX6X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 19:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUEDX6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 19:58:23 -0400
Received: from mail5-151.ewetel.de ([212.6.122.151]:19906 "EHLO
	mail5.ewetel.de") by vger.kernel.org with ESMTP id S261744AbUEDX6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 19:58:22 -0400
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: sigaction, fork, malloc, and futex
In-Reply-To: <1ShG9-2Yt-11@gated-at.bofh.it>
References: <1SeIE-Dy-17@gated-at.bofh.it> <1ShG9-2Yt-11@gated-at.bofh.it>
Date: Wed, 5 May 2004 01:57:53 +0200
Message-Id: <E1BL9nN-0000SG-Il@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 May 2004 01:40:09 +0200, you wrote in linux.kernel:
> The signal handler executes on its own signal stack, it
> can't reach anything thats located on the main program stack.

Only when using sigaltstack(2). Otherwise, by default, there is
no seperate signal stack.

-- 
Ciao,
Pascal
