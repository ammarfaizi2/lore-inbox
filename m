Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbVHPEhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbVHPEhT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 00:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVHPEhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 00:37:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65198 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932602AbVHPEhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 00:37:17 -0400
Date: Mon, 15 Aug 2005 21:37:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       jdike@addtoit.com, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       pratap@vmware.com, virtualization@lists.osdl.org,
       zwane@arm.linux.org.uk
Subject: Re: [PATCH 1/6] i386 virtualization - Fix uml build
Message-ID: <20050816043702.GS7762@shell0.pdx.osdl.net>
References: <200508152258.j7FMwdAb005304@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508152258.j7FMwdAb005304@zach-dev.vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* zach@vmware.com (zach@vmware.com) wrote:
> Attempt to fix the UML build by assuming the default i386 subarchitecture
> (mach-default).
> 
> I can't fully test this because spinlock breakage is still happening in
> my tree, but it gets rid of the mach_xxx.h missing file warnings.

I assume this is intended to fix a build error caused by patches in the
earlier set which added more reliance on mach-default?

thanks,
-chris
