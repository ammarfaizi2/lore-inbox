Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752241AbWCJWxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbWCJWxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbWCJWxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:53:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752241AbWCJWxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:53:53 -0500
Date: Fri, 10 Mar 2006 14:56:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kurt Garloff <garloff@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] KERN_SETUID_DUMPABLE in /proc/sys/fs/
Message-Id: <20060310145605.08bf2a67.akpm@osdl.org>
In-Reply-To: <20060310155738.GL5766@tpkurt.garloff.de>
References: <20060310155738.GL5766@tpkurt.garloff.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff <garloff@suse.de> wrote:
>
> Diffing in sysctl.c is tricky, using more context is recommended.
> suid_dumpable ended up in fs/ instead of kernel/ and the reason
> is likely a patch with too little context.

It's been in kernel/ since 2.6.13.  What will break if we move it?

This is security-related.  If we move it we risk unsecuring people's
machines...
