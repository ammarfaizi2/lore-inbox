Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbUDNJjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 05:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbUDNJjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 05:39:06 -0400
Received: from mail.shareable.org ([81.29.64.88]:13984 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264019AbUDNJjE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 05:39:04 -0400
Date: Wed, 14 Apr 2004 10:38:55 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Non-Exec stack patches
Message-ID: <20040414093855.GB8888@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABC@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9AB83E4717F13F419BD880F5254709E5011EBABC@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> > If so, you want to change __P110 as well as __P111.
> 
> No. Only EXEC bit is the difference.

Yes.  __P110 means WRITE+EXEC.  __P111 means READ+WRITE+EXEC.

-- Jamie
