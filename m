Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTHaFKj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 01:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTHaFKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 01:10:39 -0400
Received: from rth.ninka.net ([216.101.162.244]:49597 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261241AbTHaFKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 01:10:38 -0400
Date: Sat, 30 Aug 2003 22:10:32 -0700
From: "David S. Miller" <davem@redhat.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: lm@bitmover.com, jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-Id: <20030830221032.1edf71d0.davem@redhat.com>
In-Reply-To: <20030829230521.GD3846@matchmail.com>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
	<20030829154101.GB16319@work.bitmover.com>
	<20030829230521.GD3846@matchmail.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Aug 2003 16:05:21 -0700
Mike Fedyk <mfedyk@matchmail.com> wrote:

> Does this mean that userspace has to take into consideration that the isn't
> coherent for adjacent small memory accesses on sparc?  What could happen if
> it doesn't, or does it need to at all?

For shared memory, we enforce the correct mapping alignment
so that coherency issues don't crop up.

How does this program work?  I haven't taken a close look
at it.  Does it use MAP_SHARED or IPC shm?

