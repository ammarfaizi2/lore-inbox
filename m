Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUILVMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUILVMs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 17:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUILVMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 17:12:48 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:4776 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262071AbUILVMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 17:12:46 -0400
Date: Sun, 12 Sep 2004 23:12:45 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Serge Hallyn <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] BSD Jail LSM (2/3)
Message-ID: <20040912211244.GB24240@MAIL.13thfloor.at>
Mail-Followup-To: Serge Hallyn <serue@us.ibm.com>,
	Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <1094847705.2188.94.camel@serge.austin.ibm.com> <1094847787.2188.101.camel@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094847787.2188.101.camel@serge.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings Serge!

On Fri, Sep 10, 2004 at 03:23:07PM -0500, Serge Hallyn wrote:
> Attached is a patch against the security Kconfig and Makefile to support
> bsdjail, as well as the bsdjail.c file itself.  bsdjail offers
> functionality similar to (but more limited than) the vserver patch.
> 
> A process in a jail lives under a chroot which is not vulnerable to the
> well-known chdir(...)(etc)chroot(.) attack against normal chroots, and
> may be locked to one ip address.  For additional features, please see
> Documentation/bsdjail.txt, which is included in the next patch.

sounds good, maybe linux-vserver and bsdjail can
share/utilize common code/functionality here?

(will have a look at the code soon)

also interresting enhancements might be

 - private namespaces (linux-vserver uses them)
 - certain virtualizations (loadavg, ...)

anyway, let me know if you are interested in
any cooperation ...

best,
Herbert

> The patch applies cleanly to 2.6.8.1, and has been tested on xSeries,
> pSeries, and zSeries.
> 
> Please apply.
> 
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> 
> -serge


