Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbUDNQxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264293AbUDNQxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:53:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:54161 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264276AbUDNQxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:53:08 -0400
Date: Wed, 14 Apr 2004 09:53:03 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mq_open() and close_on_exec?
Message-ID: <20040414095303.R21045@build.pdx.osdl.net>
References: <20040413174005.Q22989@build.pdx.osdl.net> <20040414061255.GA31589@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040414061255.GA31589@devserv.devel.redhat.com>; from jakub@redhat.com on Wed, Apr 14, 2004 at 02:12:55AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jakub Jelinek (jakub@redhat.com) wrote:
> I think it is valid and required:
> http://www.opengroup.org/onlinepubs/007904975/functions/exec.html
> 
> ^[MSG] [Option Start] All open message queue descriptors in the calling process shall be closed, as described in
> mq_close() . [Option End]
> 
> I'll add a new test for this into glibc testsuite.

Thanks, I managed to miss that in the spec.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
