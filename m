Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVGOUBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVGOUBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVGOUBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:01:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:21684 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261520AbVGOUBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:01:13 -0400
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify: add x86-64 syscall numbers
References: <1121457125.830.22.camel@betsy.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Jul 2005 22:01:12 +0200
In-Reply-To: <1121457125.830.22.camel@betsy.suse.lists.linux.kernel>
Message-ID: <p73wtnrbzzr.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@novell.com> writes:

> Andi,
> 
> Attached patch adds the inotify syscall numbers to x86-64.  Also adds
> the new ioprio_get() and ioprio_set() calls to the IA32 layer.

It won't work anyways because you forgot to patch the compat 
sys32_open.

-Andi
