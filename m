Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVADW2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVADW2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVADW1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:27:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:50061 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262372AbVADW1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:27:00 -0500
Date: Tue, 4 Jan 2005 14:26:58 -0800
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Chris Wright <chrisw@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] merge *_vm_enough_memory()s into a common helper
Message-ID: <20050104142658.Z2357@build.pdx.osdl.net>
References: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com> <20050104141712.E469@build.pdx.osdl.net> <1104877039.20724.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1104877039.20724.175.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Tue, Jan 04, 2005 at 05:17:19PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Tue, 2005-01-04 at 17:17, Chris Wright wrote:
> > * Serge E. Hallyn (serue@us.ibm.com) wrote:
> > 
> > I'm fine with this with a few nits.  Although I don't think it will apply
> > to current bk which has merge error in this area right now.  Stephen,
> > are you ok with the way this one generates audit messages?
> 
> Looks like the patch (with suggested fixes) will preserve the current
> behavior, i.e. no audit message generation for SELinux from the
> vm_enough_memory hook, while still auditing real uses of CAP_SYS_ADMIN
> elsewhere.  That is what we want.

Good, thanks.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
