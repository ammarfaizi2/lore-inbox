Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVADUP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVADUP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVADUPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:15:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:52373 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262107AbVADUPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:15:07 -0500
Date: Tue, 4 Jan 2005 12:15:02 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] properly split capset_check+capset_set
Message-ID: <20050104121502.T2357@build.pdx.osdl.net>
References: <20050104162745.GA400@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050104162745.GA400@IBM-BWN8ZTBWA01.austin.ibm.com>; from serue@us.ibm.com on Tue, Jan 04, 2005 at 10:27:45AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> The attached patch removes checks from kernel/capability.c which are
> redundant with cap_capset_check() code, and moves the capset_check()
> calls to immediately before the capset_set() calls.  This allows
> capset_check() to accurately check the setter's permission to set caps
> on the target.  Please apply.
> 
> thanks,
> -serge
> 
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Signed-off-by: Chris Wright <chrisw@osdl.org>

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
