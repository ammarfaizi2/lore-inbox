Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVCIWrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVCIWrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVCIWpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:45:49 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:40684 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262067AbVCIWRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:17:13 -0500
Date: Wed, 9 Mar 2005 22:17:11 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Chris Wright <chrisw@osdl.org>
Cc: greg@kroah.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm missing memset can crash X server...
In-Reply-To: <20050309065829.GG5389@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0503092216250.17853@skynet>
References: <Pine.LNX.4.58.0503082356460.17157@skynet>
 <20050309065829.GG5389@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Could you please add Signed-off-by?  Do I read this patch correctly that
> it effectively disables the DRM_COPY in ->version callbacks?

I'll resend the patch now .. no it just zeros out the structure on the
stack so that the version callback doesn't get a garbage structure to copy
into...

Dave.


-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

