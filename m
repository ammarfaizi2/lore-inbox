Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVK0Xvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVK0Xvv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 18:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVK0Xvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 18:51:51 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:23927 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751163AbVK0Xvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 18:51:51 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       rolandd@cisco.com, mshefty@ichips.intel.com, halr@voltaire.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/infiniband/core/mad.c: fix a NULL pointer
 dereference
X-Message-Flag: Warning: May contain useful information
References: <20051126233736.GE3988@stusta.de>
From: Roland Dreier <rolandd@cisco.com>
Date: Sun, 27 Nov 2005 15:51:41 -0800
Message-ID: <52irud4pki.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 27 Nov 2005 23:51:42.0809 (UTC) FILETIME=[84846C90:01C5F3AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I already have this in my git tree of pending changes
(I found it by actually hitting the crash it causes with CONFIG_DEBUG_SLAB=y).

 - R.
