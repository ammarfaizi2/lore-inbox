Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbUB0Acl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbUB0Acl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:32:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:40601 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261370AbUB0Aci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:32:38 -0500
Date: Thu, 26 Feb 2004 16:32:36 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jochen Roemling <jochen@roemling.net>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
Message-ID: <20040226163236.M22989@build.pdx.osdl.net>
References: <1tCuq-3AH-1@gated-at.bofh.it> <1tCEo-3Lh-27@gated-at.bofh.it> <1tDgT-4r2-13@gated-at.bofh.it> <403E87CF.1080409@roemling.net> <20040226160616.E1652@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040226160616.E1652@build.pdx.osdl.net>; from chrisw@osdl.org on Thu, Feb 26, 2004 at 04:06:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> did you try setpcaps?  smth like setpcaps cap_ipc_lock+e <pid>

bah, sorry, i should point out, that isn't going to work w/out CAP_SETPCAP
which is disabled.  you'll want to start with full privs (i.e. root) and
drop all but CAP_IPC_LOCK.  SuSE used to have a tool called compartment
that helped with this, might google for it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
