Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVASTiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVASTiS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVASTiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:38:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:7351 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261482AbVASTiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:38:06 -0500
Date: Wed, 19 Jan 2005 11:38:03 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jan Knutar <jk-lkml@sci.fi>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] /proc/<pid>/rlimit
Message-ID: <20050119113803.I469@build.pdx.osdl.net>
References: <20050118204457.GA7824@ti64.telemetry-investments.com> <200501192131.59252.jk-lkml@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200501192131.59252.jk-lkml@sci.fi>; from jk-lkml@sci.fi on Wed, Jan 19, 2005 at 09:31:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Knutar (jk-lkml@sci.fi) wrote:
> On Tuesday 18 January 2005 22:44, Bill Rugolsky Jr. wrote:
> > This patch against 2.6.11-rc1-bk6 adds /proc/<pid>/rlimit to export
> > per-process resource limit settings.  It was written to help analyze
> > daemon core dump size settings, but may be more generally useful.
> > Tested on 2.6.10. Sample output:
> 
> A "cool feature" would be if you could do
> echo nofile 8192 8192 >/proc/`pidof thatserverproess`/rlimit
> :-)

This is security sensitive, and is currently only expected to be changed
by current.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
