Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVI1G7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVI1G7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 02:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVI1G7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 02:59:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750720AbVI1G7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 02:59:49 -0400
Date: Tue, 27 Sep 2005 23:58:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nate Diller <nate@namesys.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] block cleanups: remove CONFIG_IOSCHED_NOOP
Message-Id: <20050927235859.52e72714.akpm@osdl.org>
In-Reply-To: <4339C59B.7090907@namesys.com>
References: <4339C59B.7090907@namesys.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate Diller <nate@namesys.com> wrote:
>
> The no-op scheduler is always compiled in, but the build system hasn't forgotten about 
>  CONFIG_IOSCHED_NOOP yet.  This patch removes all mention of it, since its last use is removed in 
>  add-kconfig-default-iosched-submenu.

Your patches all get 100% rejects.  I fixed the other two by hand but this
one's large.   Please incinerate your copy of Mozilla and resend.
