Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWDMVRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWDMVRU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 17:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWDMVRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 17:17:20 -0400
Received: from waste.org ([64.81.244.121]:6338 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964974AbWDMVRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 17:17:19 -0400
Date: Thu, 13 Apr 2006 16:15:16 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, ak@suse.de,
       davem@davemloft.net, paulus@samba.org, manfred@colorfullife.com,
       sct@redhat.com
Subject: Re: [PATCH 1/2] add poison.h and patch primary users
Message-ID: <20060413211516.GY15445@waste.org>
References: <20060413140953.339ad6d9.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413140953.339ad6d9.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 02:09:53PM -0700, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Matt Mackall wrote:
> I think we should have a central poison.h file.
> 
> Localize poison values into one header file for better
> documentation and easier/quicker debugging and so that the
> same values won't be used for multiple purposes.
> 
> Use these constants in core arch., mm, driver, and fs code.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

Exactly.

Acked-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.
