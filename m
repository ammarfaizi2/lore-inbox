Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263925AbUDPWZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbUDPWWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:22:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:51139 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263927AbUDPWWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:22:20 -0400
Date: Fri, 16 Apr 2004 15:22:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: Alex Riesen <fork0@users.sourceforge.net>,
       Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: POSIX message queues, libmqueue: mq_open, mq_unlink
Message-ID: <20040416152217.C22989@build.pdx.osdl.net>
References: <4080060F.7030604@redhat.com> <20040416213851.GA1784@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040416213851.GA1784@steel.home>; from fork0@users.sourceforge.net on Fri, Apr 16, 2004 at 11:38:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alex Riesen (fork0@users.sourceforge.net) wrote:
> My concern is that the tests are rather pointing that something in
> kernel is not implemented correctly. _The_ checks in particular.
> Because if they _are_ implemented correctly, you don't need to patch the
> functionality in the user space.
>
> And if the kernel code does check the incoming arguments correctly,
> what is the point to check them again? Just to make the point, that
> passing in not an absolute path is not portable?

The kernel interface is simple and clean.  And in fact, requires no
slashes else you'll get -EACCES.  It's not POSIX, but the library
interface is.

We just discussed this yesterday:

http://marc.theaimsgroup.com/?t=108205593100003&r=1&w=2

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
