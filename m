Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbUDEV5z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbUDEVzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:55:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:44259 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263475AbUDEVxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:53:01 -0400
Date: Mon, 5 Apr 2004 14:53:00 -0700
From: Chris Wright <chrisw@osdl.org>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Chris Wright <chrisw@osdl.org>, John Stoffel <stoffel@lucent.com>,
       Timothy Miller <miller@techsource.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
Message-ID: <20040405145300.P21045@build.pdx.osdl.net>
References: <20040405140810.C22989@build.pdx.osdl.net> <20040405214007.68717.qmail@web40506.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040405214007.68717.qmail@web40506.mail.yahoo.com>; from serge_lozovsky@yahoo.com on Mon, Apr 05, 2004 at 02:40:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sergiy Lozovsky (serge_lozovsky@yahoo.com) wrote:
> LSM use another way of doing similar things :-) I'm
> not sure that it is nice to forward system calls back
> to userspace where they came from in the first place
> :-) VXE use high level language to create security
> models.

There's no requirement in LSM to forward syscalls back to userspace for
access control check.  At any rate, seems you like your solution, just
wanted to make sure you were aware of alternatives.

> And what are the problems with technology used by VXE?

It's the LISP interpreter that's problematic.  As you've already seen
with the kernel stack limitations.

> File permissions are checked in the kernel and
> everybody are happy with that. VXE just extends
> security features already available in the kernel.

And LSM checks are done in kernel.

> There is a historic part to all that, too - VXE was
> created (1999) before SELinux was available.

Ah, the real truth ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
