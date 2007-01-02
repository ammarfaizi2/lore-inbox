Return-Path: <linux-kernel-owner+w=401wt.eu-S932744AbXABKX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbXABKX3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 05:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbXABKX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 05:23:29 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60840 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932744AbXABKX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 05:23:28 -0500
Date: Tue, 2 Jan 2007 10:33:32 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Theodore Tso <tytso@mit.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Print sysrq-m messages with KERN_INFO priority
Message-ID: <20070102103332.46de83bd@localhost.localdomain>
In-Reply-To: <20070102043743.GB15718@thunk.org>
References: <E1H0Uq5-0003Fo-1W@candygram.thunk.org>
	<20061229204247.be66c972.akpm@osdl.org>
	<20070102043743.GB15718@thunk.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2007 23:37:43 -0500
Theodore Tso <tytso@mit.edu> wrote:
> > Is this patch a consistency thing?
> 
> The goal of the patch was to avoid filling /var/log/messages huge
> amounts of sysrq text.  Some of the sysrq commands, especially sysrq-m
> and sysrq-t emit a truly vast amount of information, and it's not
> really nice to have that filling up /var/log/messages.  

I find it extremely useful that it ends up in /var/log/messages so that I
can review the dump later. Often the first glance through a set of dumps
on things like a process deadlock don't reveal the right information and
you need to go back and look again.

Alan
