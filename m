Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVCMEZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVCMEZl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 23:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbVCMEZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 23:25:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41902 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262878AbVCMEZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 23:25:07 -0500
Date: Sat, 12 Mar 2005 23:24:59 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: adaplas@pol.net
Subject: nvidia fb licensing issue.
Message-ID: <20050313042459.GF32494@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, adaplas@pol.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The nvidia framebuffer code added recently is marked as
MODULE_LICENSE(GPL), but some things seem a little odd to me..

1. The boilerplate at the top of drivers/video/nvidia/nv_dma.h,
   drivers/video/nvidia/nv_local.h, and drivers/video/nvidia/nv_hw.c
   doesn't seem to be a GPL-compatible license. It seems to be an nvidia
   specific license with an advertising clause, and something that
   adds restrictions on rights of U.S. Govt end users.

2. Some of these files clearly came from XFree86 judging from
   the CVS idents in the source.  Was this XFree86 code
   dual-licensed by its original authors ? If so, it isn't clear.

		Dave

