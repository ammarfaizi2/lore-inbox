Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWEVRjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWEVRjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWEVRjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:39:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751081AbWEVRjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:39:31 -0400
Date: Mon, 22 May 2006 10:39:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: rdunlap@xenotime.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmap tracking
Message-Id: <20060522103915.53e03867.akpm@osdl.org>
In-Reply-To: <4471EA2C.4010401@oracle.com>
References: <20060518155357.04066e9c.rdunlap@xenotime.net>
	<4471EA2C.4010401@oracle.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown <zach.brown@oracle.com> wrote:
>
>  Randy.Dunlap wrote:
>  > From: Randy Dunlap <rdunlap@xenotime.net>
>  > 
>  > Track kmap/kunmap call history, storing caller function address,
>  > action, and time (jiffies), if CONFIG_DEBUG_KMAP is enabled.
>  > Based on a patch to 2.4.21 by Zach Brown that was used successfully
>  > at Oracle to track down some kmap/kunmap problems.
> 
>  Thanks for bringing this to 2.6.. sorry for the lag in reviewing.

I was scratching my head over this patch trying to think of any bug in
recent years which it would have detected.  I failed.

So...  what's the motivator here?
