Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVHGBLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVHGBLy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 21:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVHGBJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 21:09:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40660 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261406AbVHGBH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 21:07:26 -0400
Date: Sat, 6 Aug 2005 18:07:21 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, chrisl@vmware.com
Subject: Re: [PATCH] 3/8 Move sensitive system definitions into the sub-arch layer
Message-ID: <20050807010721.GH7762@shell0.pdx.osdl.net>
References: <42F4634B.6040201@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F4634B.6040201@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> i386 Transparent Paravirtualization Subarch Patch #3
> 
> This change encapsulates privileged control register and flags accessors into
> the sub-architecture layer.  The goal is a clean, uniform interface that may
> be redefined on new sub-architectures of i386.

I had cheated on this on and the io insn's and pushed the whole thing to
subarch.  That's only from lack of time, so I'll revisit this one
tomorrow.

thanks,
-chris
