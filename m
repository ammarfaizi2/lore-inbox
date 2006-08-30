Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbWH3Wuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbWH3Wuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWH3Wui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:50:38 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:61394 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751424AbWH3Wui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:50:38 -0400
Date: Wed, 30 Aug 2006 23:50:36 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [FOR 2.6.18 FIX][PATCH]  drm: radeon flush TCL VAP for vertex
 program enable/disable
In-Reply-To: <20060830154152.9ac71753.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0608302348160.21600@skynet.skynet.ie>
References: <Pine.LNX.4.64.0608302314360.21600@skynet.skynet.ie>
 <20060830154152.9ac71753.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That's a somewhat weird-looking patch.  It adds code which is quite
> dissimilar from all the other cases in that switch statement.
>
> Are you sure??

Yes it is the least likely to break anything spot, it is a type of fixup 
required for that packet to avoid lockups, there was a really ugly 
workaround in userspace...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

