Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTJCIWB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 04:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTJCIWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 04:22:01 -0400
Received: from ns.suse.de ([195.135.220.2]:50651 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263619AbTJCIV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 04:21:58 -0400
To: <bvds@bvds.geneva.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: segfault error on x86_64
References: <20031002215345.A1D33E24D6@bvds.geneva.edu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Oct 2003 10:20:53 +0200
In-Reply-To: <20031002215345.A1D33E24D6@bvds.geneva.edu.suse.lists.linux.kernel>
Message-ID: <p73y8w2yboa.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<bvds@bvds.geneva.edu> writes:

> I have kernel 2.4.22 compiled with gcc 3.3 running on a 
> dual AMD Opteron (in 64 bit mode).  
> There is an error message that occurs about twice a day at random times:
> 
> Sep 30 23:45:00 gideon kernel: bumps[12960]: segfault at 0000002a95611000 rip 0000000000402150 rsp 0000007fbffff1a8 error 6
> Oct  1 10:26:57 gideon kernel: bumps[13510]: segfault at 0000002a95611000 rip 0000000000402150 rsp 0000007fbffff1a8 error 6
> 
> As far as I can tell, there is no other effect than this message.
> (the system keeps running OK).
> 
> What is "bumps" ?

Some random program on your system. The x86-64 kernel logs all unhandled
segfaults by default. It is unlikely to be a kernel problem.

-Andi
