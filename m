Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVCXKes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVCXKes (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 05:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVCXKer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 05:34:47 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:31709 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262432AbVCXKeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 05:34:46 -0500
Date: Thu, 24 Mar 2005 10:33:02 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Cc: dri-devel@lists.sf.net
Subject: drm bugs hopefully fixed but there might still be one..
Message-ID: <Pine.LNX.4.58.0503241015190.7647@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew, Dave,

I've put a couple of patches into my drm-2.6 tree that hopefully fix up
the multi-bridge on i915 and the XFree86 4.3 issue.. Andrew can you drop
the two patches in your tree.. the one from Brice and the one I attached
to the bug? you'll get conflicts anyway I'm sure. I had to modify Brices
one as it didn't look safe to me in all cases..

I think their might be one left, but I think it only seems to be on
non-intel AGP system, as in my system works fine for a combination of
cards and X releases ... anyone with a VIA chipset and Radeon graphics
card or r128 card.. testing the next -mm would help me a lot..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

