Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbUJZFAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUJZFAC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUJZEze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 00:55:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:5526 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261942AbUJZEvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 00:51:50 -0400
Date: Mon, 25 Oct 2004 21:49:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] make dnotify a configure-time option
Message-Id: <20041025214947.63031519.akpm@osdl.org>
In-Reply-To: <1098765164.6034.38.camel@localhost>
References: <1098765164.6034.38.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@novell.com> wrote:
>
>  Everything is straightforward, except the removal of the
>  dir_notify_enable boot-time option.  My contention is that there is no
>  reason to make dnotify a boot-time option.  But even if there is, then
>  surely the user wants it always off, in which case the compile-time
>  option fulfills the need.

It's actually a sysctl and is also present in 2.4.  I doubt if it's very
useful but it seems a bit random to be deleting it now.
