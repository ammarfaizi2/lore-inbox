Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267443AbUBSRqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267444AbUBSRqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:46:21 -0500
Received: from smtp-gw.fnbs.net.my ([202.9.108.191]:8973 "EHLO
	smtp-gw.fnbs.net.my") by vger.kernel.org with ESMTP id S267443AbUBSRqU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:46:20 -0500
Subject: Re: Security update patch to 2.6.3 for mremap()?
From: Nur Hussein <obiwan@slackware.org.my>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040219170051.6b97f6bf.diegocg@teleline.es>
References: <1077201466.1636.19.camel@sophia.localdomain>
	 <20040219170051.6b97f6bf.diegocg@teleline.es>
Content-Type: text/plain
Message-Id: <1077212582.223.17.camel@sophia.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 01:43:02 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the clarification, and I apologize for my previous email
which went horribly wrong wrt formatting.

> AFAIK, the 2.4 path should be this one, shouldn't it?
> http://linux.bkbits.net:8080/linux-2.4/patch@1.1323?nav=index.html|ChangeSet@-2d|cset@1.1323

> http://linux.bkbits.net:8080/linux-2.5/diffs/mm/mremap.c@1.38?nav=index.html|src/|src/mm|hist/mm/mremap.c
> 2.6.3 is safe, it seems

Yes, those two patches seem to match up.

However, I am still intrigued by this fix:

http://linux.bkbits.net:8080/linux-2.4/diffs/mm/mremap.c@1.7?nav=cset@1.1136.94.4

It does not seem to be in 2.6.3. I can only assume 2.6.x does not
require it? The Changeset says it is to prevent a potential exploit by
the malicious use of mremap().

-= Nur Hussein =-

