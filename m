Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbUKRKga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbUKRKga (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUKRKds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:33:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:42116 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262723AbUKRKbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:31:41 -0500
Date: Thu, 18 Nov 2004 02:31:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm1
Message-Id: <20041118023123.4365de41.akpm@osdl.org>
In-Reply-To: <20041118102210.GB3217@holomorphy.com>
References: <20041116014213.2128aca9.akpm@osdl.org>
	<20041117113225.GP3217@holomorphy.com>
	<20041117123401.GQ3217@holomorphy.com>
	<20041117125624.GR3217@holomorphy.com>
	<20041118102210.GB3217@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Wed, Nov 17, 2004 at 04:56:24AM -0800, William Lee Irwin III wrote:
> > It does not appear to have helped. So bk snapshot searching it is. =(
> 
> sparc64 broke between 2.6.9 and 2.6.10-rc1. Are there any split-up
> diffs of what went on between 2.6.9 and 2.6.10-rc1?
> 

That'll be hard to do, because 2.6.9->2.6.10-rc1 was one of those brief
periods of frenetic patchbombing.

You could try 2.6.9-rc4-mm1 and if the bug is there, try 2.6.9-rc4-mm1's
linus.patch and if the bug is not there, iterate though 2.6.9-rc4-mm1's
patches.

If the bug isn't in 2.6.9-rc4-mm1 I guess you're down to a binary search
with `bk clone'.  It might be a bit easier with bkcvs actually.
