Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUCQScK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbUCQScK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:32:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:27100 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261937AbUCQScH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:32:07 -0500
Date: Wed, 17 Mar 2004 10:32:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Quota locking
Message-Id: <20040317103210.3d074eb7.akpm@osdl.org>
In-Reply-To: <20040317175643.GA25337@atrey.karlin.mff.cuni.cz>
References: <20040317175643.GA25337@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@ucw.cz> wrote:
>
>   I've extracted the locking changes from journalled quota patch
>  relevant for vanilla kernel (basically fixes the lock ordering in some
>  cases). The patch also includes documentation of the quota locking.

Sure, I'll queue that up.  It breaks the journalled quota patches of course,
so I dropped those.

Is the same code as was in the journalled quota patch?  If so, it's
reasonably well tested.

I assume you'll be reworking the ext3 journalled quota patches?

> The patch is not trivial so are you willing to accept it in the vanilla
> kernel?

Sure.  Probably soon after 2.6.5 is released?
