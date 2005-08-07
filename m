Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVHGBDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVHGBDY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 21:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVHGBDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 21:03:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261358AbVHGBDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 21:03:23 -0400
Date: Sat, 6 Aug 2005 18:02:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, chrisl@vmware.com
Subject: Re: [PATCH 1/8] Move MSR accessors into the sub-arch layer
Message-ID: <20050807010247.GF7762@shell0.pdx.osdl.net>
References: <42F4626D.1000401@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F4626D.1000401@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> i386 Transparent Paravirtualization Subarch Patch #1
> 
> This change encapsulates MSR register accessors and moves them into the
> sub-architecture layer.  The goal is a clean, uniform interface that may
> be redefined on new sub-architectures of i386.

I currently have nothing analgous for Xen, but this one looks sane.

thanks,
-chris
