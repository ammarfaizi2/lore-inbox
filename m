Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVAUTSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVAUTSX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbVAUTSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:18:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:12208 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262517AbVAUTRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:17:02 -0500
Date: Fri, 21 Jan 2005 11:17:00 -0800
From: Chris Wright <chrisw@osdl.org>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050121111700.Q469@build.pdx.osdl.net>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu> <20050121093902.O469@build.pdx.osdl.net> <csrje8$bsn$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <csrje8$bsn$1@abraham.cs.berkeley.edu>; from daw@taverner.cs.berkeley.edu on Fri, Jan 21, 2005 at 06:59:20PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Wagner (daw@taverner.cs.berkeley.edu) wrote:
> There is a simple tweak to ptrace which fixes that: one could add an
> API to specify a set of syscalls that ptrace should not trap on.  To get
> seccomp-like semantics, the user program could specify {read,write}, but
> if the user program ever wants to change its policy, it could change that
> set.  Solaris /proc (which is what is used for tracing) has this feature.
> I coded up such an extension to ptrace semantics a long time ago, and
> it seemed to work fine for me, though of course I am not a ptrace expert.

Hmm, yeah, that'd be nice.  That only leaves the issue of tracer dying
(say from that crazy oom killer ;-).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
