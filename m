Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753417AbWKFQv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbWKFQv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbWKFQv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:51:58 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:7569 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1753417AbWKFQv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:51:57 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CANL1TkWrRApP/2dsb2JhbAA
X-IronPort-AV: i="4.09,392,1157353200"; 
   d="scan'208"; a="1862299645:sNHT6585986100"
To: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Cc: rolandd@cisco.com, Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control block in 64k page mode
X-Message-Flag: Warning: May contain useful information
References: <OF69697CF5.13DC8781-ONC125721E.0039CD42-C125721E.003A3D50@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Nov 2006 08:51:53 -0800
In-Reply-To: <OF69697CF5.13DC8781-ONC125721E.0039CD42-C125721E.003A3D50@de.ibm.com> (Hoang-Nam Nguyen's message of "Mon, 6 Nov 2006 11:39:09 +0100")
Message-ID: <adaodrko6vq.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Nov 2006 16:51:53.0870 (UTC) FILETIME=[DCD75AE0:01C701C3]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > As Arnd stated I need to fix this ctor issue. Do you prefer me to resend
 > all patches in proper format (non-mangled inline) or just this one bug fix?

I have the rest of the patches, so you just need to resend a fixed
version of this one.  BTW see my previous response about
kmem_cache_zalloc() -- I think that's the best way to fix this.

In the future though if you can make a patch-sending script or
something that lets you avoid the attachments that would be great.
