Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVKFWjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVKFWjd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVKFWjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:39:33 -0500
Received: from ozlabs.org ([203.10.76.45]:20675 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751257AbVKFWjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:39:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17262.34331.226287.178898@cargo.ozlabs.ibm.com>
Date: Mon, 7 Nov 2005 09:39:23 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
In-Reply-To: <20051106112838.0d524f65.akpm@osdl.org>
References: <Pine.LNX.4.61.0511031924210.31509@goblin.wat.veritas.com>
	<20051106112838.0d524f65.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> I don't know what the access address was (ia32 nicely tells you), but if
> it's `DAR' then we have LIST_POISON1.

Yes, DAR is the access address.

Paul.
