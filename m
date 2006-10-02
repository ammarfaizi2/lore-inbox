Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWJBRSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWJBRSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWJBRSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:18:31 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:18022 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965148AbWJBRSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:18:30 -0400
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, openfabrics-ewg@openib.org
Subject: Re: [PATCH 2.6.19-rc1] ehca: fix ehca_probe if module loaded after ib_ipoib
X-Message-Flag: Warning: May contain useful information
References: <200610021908.52695.hnguyen@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 02 Oct 2006 10:18:29 -0700
In-Reply-To: <200610021908.52695.hnguyen@de.ibm.com> (Hoang-Nam Nguyen's message of "Mon, 2 Oct 2006 19:08:52 +0200")
Message-ID: <adamz8ews9m.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Oct 2006 17:18:30.0025 (UTC) FILETIME=[C7C40790:01C6E646]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks OK but your mailer mangled the patch.  Please resend in a form
that can be applied...

Also:

 > In addition to that this patch contains a very small format improvement 
 > in our tracing function.

please send unrelated changes as separate patches.
So this should come as two patches -- one to fix the device
registration, and one to change your debug formatting.

Thanks,
  Roland
