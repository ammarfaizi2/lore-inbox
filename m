Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVDGMiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVDGMiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 08:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVDGMiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 08:38:54 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:39133 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262448AbVDGMiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 08:38:51 -0400
Date: Thu, 7 Apr 2005 13:38:52 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk tree] DRM add a version check.. for 2.6.12 (distro kernel
 maintainers + drm users plz read also...)
In-Reply-To: <20050407114933.GH3858@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.58.0504071334560.25035@skynet>
References: <Pine.LNX.4.58.0503281236330.27073@skynet>
 <20050407114933.GH3858@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I tried 2.6.12-rc2 which includes this patch, and I get DRM failures
> here, which causes application and X to hang.  (I got failures with 2.6.11
> also.)

Does the FC-4 test kernel work? There was a bug in X6.8.2 but I think it
would be fixed in FC-4 test.. I run Xorg CVS on a 9200 with the latest
kernel and it seems fine... granted I've been able to crash it with
running a few wierd apps.. I've just had no chance to debug it yet but it
isn't the common case... maybe I should play tuxracer for a while..

the symptoms are typical of a card lockup, spinning in ioctl forever...

Dave.


-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

