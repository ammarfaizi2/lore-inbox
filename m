Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVIVUwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVIVUwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVIVUwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:52:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38591 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751183AbVIVUwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:52:17 -0400
Date: Thu, 22 Sep 2005 13:52:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: breno@kalangolinux.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: security patch
Message-ID: <20050922205209.GL7991@shell0.pdx.osdl.net>
References: <20050922194433.13200.qmail@webmail2.locasite.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922194433.13200.qmail@webmail2.locasite.com.br>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* breno@kalangolinux.org (breno@kalangolinux.org) wrote:
> I'm doing a new feature for linux kernel 2.6 to protect against all kinds of buffer
> overflow. It works with new sys_control() system call controling if a process can or can't
> call a system call ie. sys_execve();

This is insufficient to protect against buffer overflow.  You are
re-inventing something that's been done multiple times.  Each are
arguably more effective.  Look at the seccomp option in current kernels.
Look also to policy enforcement via something expressive such as
SELinux.

> I think it can be an option in linux kernel.

We've got what we need in the kernel now.

thanks,
-chris
