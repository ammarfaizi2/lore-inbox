Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbULQRDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbULQRDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 12:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbULQRDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 12:03:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:10127 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261962AbULQRDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 12:03:20 -0500
Date: Fri, 17 Dec 2004 09:03:18 -0800
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Split bprm_apply_creds into two functions
Message-ID: <20041217090317.V2357@build.pdx.osdl.net>
References: <20041215200005.GB3080@IBM-BWN8ZTBWA01.austin.ibm.com> <1103145355.32732.55.camel@moss-spartans.epoch.ncsc.mil> <20041216182529.GC3260@IBM-BWN8ZTBWA01.austin.ibm.com> <1103292602.3437.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1103292602.3437.40.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Fri, Dec 17, 2004 at 09:10:02AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Thu, 2004-12-16 at 13:25, Serge E. Hallyn wrote:
> > Thanks.  Here is an updated patch.
> > 
> > -serge
> > 
> > Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> 
> Ok with me.  Chris, would it help alleviate your concerns to give the
> hook a clearer name and description, e.g. bprm_post_apply_creds and move
> the discussion about performing other state changes on the process like
> closing descriptors from the current description of bprm_apply_creds to
> it?

Yes.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
