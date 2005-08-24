Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbVHXT4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbVHXT4K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbVHXT4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:56:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751506AbVHXT4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:56:09 -0400
Date: Wed, 24 Aug 2005 12:55:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>
Subject: Re: [PATCH 3/5] Make set_wrprotect() value safe
Message-ID: <20050824195559.GL7762@shell0.pdx.osdl.net>
References: <200508241843.j7OIhC7a001888@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508241843.j7OIhC7a001888@zach-dev.vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> The macro set_wrprotect() should not be defined to have a value.  Make it
> a do {} while(0) instead of ({}).
> Noticed by Chris Wright.

I already fixed that one in the virt-2.6 git tree.

thanks,
-chris
