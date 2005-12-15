Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbVLOEcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVLOEcU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVLOEcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:32:20 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:53442 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S965010AbVLOEcT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:32:19 -0500
Date: Wed, 14 Dec 2005 23:32:12 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Dave Airlie <airlied@linux.ie>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [BUG] Xserver startup locks system... git bisect results
Message-ID: <20051215043212.GA4479@jupiter.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

git bisect said:
> 47807ce381acc34a7ffee2b42e35e96c0f322e52 is first bad commit
> diff-tree 47807ce381acc34a7ffee2b42e35e96c0f322e52 (from 0e670506668a43e1355b8f10c33d081a676bd521)
> Author: Dave Airlie <airlied@linux.ie>
> Date:   Tue Dec 13 04:18:41 2005 +0000
> 
>     [drm] fix radeon aperture issue

With this one applied, my machine locks up tight just after starting the
Xserver.  Some info (dmesg, lspci, config) is here:

http://members.dca.net/mhoffman/lkml-20051214/

I can put a serial console on it if necessary, but not until about this
time tomorrow.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

