Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268031AbUHFAig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbUHFAig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUHFAif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:38:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:47788 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268028AbUHFAi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:38:28 -0400
Date: Thu, 5 Aug 2004 17:36:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RSS ulimit enforcement for 2.6.8
Message-Id: <20040805173650.4e7a8405.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0408052016490.8229-100000@dhcp83-102.boston.redhat.com>
References: <20040805153116.3e820106.akpm@osdl.org>
	<Pine.LNX.4.44.0408052016490.8229-100000@dhcp83-102.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
>  > Also, I wonder if it would be useful if refill_inactive_zone() were to
>  > unconditionally move pages from over-rss-limit mm's onto the inactive
>  > list, ignoring swappiness.  Or if we should explicitly deactivate pages
>  > which are newly added to the LRU on behalf of an over-rss-limit process.
> 
>  If the current patch isn't effective enough, we may want
>  to add more code.  However, we may want to try the simplest
>  possible approach first.

How do we know whether it is effective enough?  How do we define this?
