Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTEVLZz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 07:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTEVLZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 07:25:55 -0400
Received: from ns.suse.de ([213.95.15.193]:26639 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261773AbTEVLZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 07:25:54 -0400
To: Martin Wirth <martin.wirth@dlr.de>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
References: <3ECCB319.4060706@dlr.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 May 2003 13:38:01 +0200
In-Reply-To: <3ECCB319.4060706@dlr.de.suse.lists.linux.kernel>
Message-ID: <p73llwz8b52.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wirth <martin.wirth@dlr.de> writes:
>       mmap/munmap on a second processor).
>    2. no vcache pollution (I guess 99% of all futexes will not be in
> shared memory)

- Could also be specified as a mutex attribute in pthreads/NPTL to get faster
mutexes (or perhaps a environment variable to allow users easy tuning)

-Andi
