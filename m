Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUDLSkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 14:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbUDLSkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 14:40:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:25287 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263014AbUDLSkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 14:40:07 -0400
Date: Mon, 12 Apr 2004 11:40:03 -0700
From: Chris Wright <chrisw@osdl.org>
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Cc: Andy Lutomirski <luto@myrealbox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH, local root on 2.4, 2.6?] compute_creds race
Message-ID: <20040412114003.M22989@build.pdx.osdl.net>
References: <4076F02E.1000809@myrealbox.com> <87brm015uj.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87brm015uj.fsf@goat.bogus.local>; from olaf+list.linux-kernel@olafdietsche.de on Sat, Apr 10, 2004 at 12:32:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Olaf Dietsche (olaf+list.linux-kernel@olafdietsche.de) wrote:
> In linux 2.4.25 there is no LSM and thus no vulnerability.

And, more specifically, the locking is sufficient.

> linux-2.4.25/fs/exec.c:
> 		lock_kernel();
> 		if (must_not_trace_exec(current)

...

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
