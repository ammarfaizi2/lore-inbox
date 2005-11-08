Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbVKHAl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVKHAl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965648AbVKHAl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:41:26 -0500
Received: from ozlabs.org ([203.10.76.45]:39554 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965081AbVKHAlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:41:25 -0500
Date: Tue, 8 Nov 2005 11:39:01 +1100
From: Anton Blanchard <anton@samba.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] Memory Add Fixes for ppc64
Message-ID: <20051108003901.GO12353@krispykreme>
References: <20051104231552.GA25545@w-mikek2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104231552.GA25545@w-mikek2.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mike,

> When memory add was merged into mainline in 2.6.14, there were
> various bits and pieces missing that prevent it from working on
> ppc64.  The following patches are against 2.6.14-git7 and address
> all but one of the know issues.
> 
> 1) Create hptes for new sections
> 2) Clear page count before freeing new pages
> 3) Kludge to add new memory to node 0
> 4) Ensure probe file is created for memory add via sysfs

Ive got a patch that reworks our numa code and it might reject with
your stuff. I'll send them out for review this afternoon.

Anton
