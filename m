Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVHDS6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVHDS6H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVHDS6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:58:07 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:52097 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S262627AbVHDS6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:58:00 -0400
X-IronPort-AV: i="3.95,168,1120460400"; 
   d="scan'208"; a="202776721:sNHT27667828"
To: Arjan van de Ven <arjan@infradead.org>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Move InfiniBand .h files
X-Message-Flag: Warning: May contain useful information
References: <52iryla9r5.fsf@cisco.com>
	<1123178038.3318.40.camel@laptopd505.fenrus.org>
	<52acjxa70j.fsf@cisco.com>
	<1123180717.3318.43.camel@laptopd505.fenrus.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 04 Aug 2005 11:57:55 -0700
In-Reply-To: <1123180717.3318.43.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Thu, 04 Aug 2005 20:38:37 +0200")
Message-ID: <52wtn18r7w.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Aug 2005 18:57:56.0127 (UTC) FILETIME=[6CB0F2F0:01C59926]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> Also, drivers/infiniband/include doesn't get put into the
    Roland> /lib/modules/<ver>/build directory,

    Arjan> that is a symlink not a directory, and a symlink to the
    Arjan> full source...

Sorry, I was too terse about the problem.  You're right, but typical
distros don't ship full kernel source in their "support kernel builds"
package.  And if I use an external build directory (ie "O=") then
the symlink just points to my external build directory, which doesn't
include the source to drivers/, just links to include/

 - R.
