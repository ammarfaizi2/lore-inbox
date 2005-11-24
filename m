Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbVKXKok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbVKXKok (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 05:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbVKXKok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 05:44:40 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:30128 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030363AbVKXKoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 05:44:39 -0500
Date: Thu, 24 Nov 2005 10:44:26 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <unichrome@shipmail.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@gmail.com>,
       "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>
Subject: Re: 2.6.14-rt4: via DRM errors
In-Reply-To: <8964.192.138.116.230.1132825958.squirrel@192.138.116.230>
Message-ID: <Pine.LNX.4.58.0511241018050.14276@skynet>
References: <1132807985.1921.82.camel@mindpipe>
 <8964.192.138.116.230.1132825958.squirrel@192.138.116.230>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I made a fix to the locking code in main drm a couple of months ago.
>
> The X server tries to get the DRM_QUIESCENT lock, but when the wait was
> interrupted by a signal (like when you move a window around), the locking
> function returned without error. This made the X server release other
> clients' locks.
>
> This does affect all drivers with a quiescent() function. Not only via.
>
> But it looks like this fix never made it into the kernel source?
> Dave?

oops... on its way now ..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

