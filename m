Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbVHZQlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbVHZQlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 12:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbVHZQlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 12:41:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39593 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965114AbVHZQlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 12:41:50 -0400
Date: Fri, 26 Aug 2005 09:41:40 -0700
From: Chris Wright <chrisw@osdl.org>
To: serue@us.ibm.com
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       Kurt Garloff <garloff@suse.de>, Stephen Smalley <sds@epoch.ncsc.mil>,
       linux-security-module@wirex.com
Subject: Re: [PATCH 0/5] LSM hook updates
Message-ID: <20050826164139.GK7762@shell0.pdx.osdl.net>
References: <20050825012028.720597000@localhost.localdomain> <Pine.LNX.4.63.0508250038450.13875@excalibur.intercode> <20050825053208.GS7762@shell0.pdx.osdl.net> <20050825191548.GY7762@shell0.pdx.osdl.net> <20050826092306.GA429@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826092306.GA429@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* serue@us.ibm.com (serue@us.ibm.com) wrote:
> Here are some numbers on a 4way x86 - PIII 700Mhz with 1G memory (hmm,
> highmem not enabled).  I should hopefully have a 2way ppc available
> later today for a pair of runs.

Thanks for running these numbers Serge.

> dbench and tbench were run 50 times each, kernbench and reaim 10 times
> each.  Results are mean +/- 95% confidence half-interval.  Kernel had
> selinux and capabilities compiled in.
> 
> A little surprising: kernbench is improved, but dbench and tbench
> are worse - though within the 95% CI.

It is interesting.  Would be good to see what happens with the cap_ bits
used in SELinux instead of secondary callout.  Also, need to run ia64,
do you have an ia64 box?

thanks,
-chris
