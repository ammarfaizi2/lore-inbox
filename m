Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTIWSCp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbTIWSCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:02:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:25514 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262040AbTIWSCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:02:30 -0400
Date: Tue, 23 Sep 2003 11:02:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Chris Wright <chrisw@osdl.org>, David Yu Chen <dychen@stanford.edu>,
       lkml <linux-kernel@vger.kernel.org>, mc@cs.stanford.edu,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030923110219.A15247@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <20030919160459.K27079@osdlab.pdx.osdl.net> <1064322949.3851.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1064322949.3851.10.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Tue, Sep 23, 2003 at 09:15:49AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> Sorry for the duplicated effort, but I had already written up a patch
> prior to the hurricane, but didn't get it sent out.  I believe that the
> patch below fixes the legitimate leaks in the SELinux code.  In some
> cases, it rearranges the code (moving the allocation later to reduce the
> need for further cleanup or linking the object into a containing
> structure earlier so that the policydb_destroy will handle it upon any
> subsequent errors).

No problem, your patch looks better anyway ;-)
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
