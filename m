Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVGKAmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVGKAmc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVGKAmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 20:42:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:51883 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261193AbVGKAma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 20:42:30 -0400
Subject: Re: [PATCH 0/82] changing CONFIG_LOCALVERSION rebuilds too much,
	for no good reason.
From: Josh Boyer <jdub@us.ibm.com>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>
References: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>
Content-Type: text/plain
Date: Sun, 10 Jul 2005 19:42:20 -0500
Message-Id: <1121042540.3408.3.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-10 at 19:35 +0000, Olaf Hering wrote:
> The following series of patches removes almost all inclusions
> of linux/version.h. The 3 #defines are unused in most of the touched files.
> 
> A few drivers use the simple KERNEL_VERSION(a,b,c) macro, which is unfortunatly
> in linux/version.h. This define moved to linux/utsname.h
> 
> There are also lots of #ifdef for long obsolete kernels, this will go as well.

Unless I missed it in the patch-bomb, you missed fs/jffs2/ and
include/linux/jffs2_fs_i.h.

josh

