Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVEJBsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVEJBsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 21:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVEJBsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 21:48:12 -0400
Received: from colin.muc.de ([193.149.48.1]:11537 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261518AbVEJBsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 21:48:08 -0400
Date: 10 May 2005 03:48:07 +0200
Date: Tue, 10 May 2005 03:48:07 +0200
From: Andi Kleen <ak@muc.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X86_64 Ctx switch times - 32bit vs 64bit
Message-ID: <20050510014807.GA97046@muc.de>
References: <200505052138.57821.kernel-stuff@comcast.net> <m1mzr7w14o.fsf@muc.de> <200505092131.36126.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505092131.36126.kernel-stuff@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> samples  %        symbol name
> 20820    11.5424  copy_user_generic_c
> 12990     7.2015  ia32_syscall
> 10131     5.6165  gs_change
> 9053      5.0189  __dequeue_signal
> 7494      4.1546  find_pid

Context switch does not even appear. Probably the i386 glibc does
something much slower than 64bit. I would compare straces.

-Andi
