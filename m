Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVCIG7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVCIG7D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVCIG7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:59:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:31703 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261560AbVCIG6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:58:38 -0500
Date: Tue, 8 Mar 2005 22:58:29 -0800
From: Chris Wright <chrisw@osdl.org>
To: Dave Airlie <airlied@linux.ie>
Cc: greg@kroah.com, chrisw@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm missing memset can crash X server...
Message-ID: <20050309065829.GG5389@shell0.pdx.osdl.net>
References: <Pine.LNX.4.58.0503082356460.17157@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503082356460.17157@skynet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Airlie (airlied@linux.ie) wrote:
> 
> Egbert Eich reported a bug 2673 on bugs.freedesktop.org and tracked it
> down to a missing memset in the setversion ioctl, this causes X server
> crashes so I would like to see the fix in a 2.6.11.x tree if possible..

Could you please add Signed-off-by?  Do I read this patch correctly that
it effectively disables the DRM_COPY in ->version callbacks?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
