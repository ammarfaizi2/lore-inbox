Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVAUSuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVAUSuL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVAUSuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:50:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:54171 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262459AbVAUSuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:50:07 -0500
Date: Fri, 21 Jan 2005 10:50:01 -0800
From: Chris Wright <chrisw@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrea Arcangeli <andrea@cpushare.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050121105001.A24171@build.pdx.osdl.net>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu> <20050121093902.O469@build.pdx.osdl.net> <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com>; from riel@redhat.com on Fri, Jan 21, 2005 at 01:39:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel (riel@redhat.com) wrote:
> Yes, but do you care about the performance of syscalls
> which the program isn't allowed to call at all ? ;)

Heh, no, but it's for every syscall not just denied ones.  Point is
simply that ptrace (complexity aside) doesn't scale the same.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
