Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271106AbTHCVBE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271184AbTHCVBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:01:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:14987 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271106AbTHCU7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:59:17 -0400
Date: Sun, 3 Aug 2003 14:00:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org, devik@cdi.cz
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel
 from being modified easily
Message-Id: <20030803140031.7665546c.akpm@osdl.org>
In-Reply-To: <20030803204515.GA15271@outpost.ds9a.nl>
References: <20030803180950.GA11575@outpost.ds9a.nl>
	<20030803123218.7bb2c16f.akpm@osdl.org>
	<20030803204515.GA15271@outpost.ds9a.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> wrote:
>
> as one of the 'tastemasters', what are your thoughts on doing this
> dynamically? The sigsegv option might be a dynamic option?

who, me?  umm...

I can see that a patch like this would have a place in a general
security-hardened kernel: one which closes off all the means by which root
can alter the running kernel.

But that's a specialised thing which interested parties can maintain as a
standalone patch, and bringing just one part of it into the main kernel
seems rather arbitrary.
 
