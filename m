Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269260AbUJQULh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269260AbUJQULh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbUJQULf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:11:35 -0400
Received: from gate.in-addr.de ([212.8.193.158]:42722 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S269290AbUJQULb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:11:31 -0400
Date: Sun, 17 Oct 2004 22:11:18 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Buddy Lucas <buddy.lucas@gmail.com>, Martijn Sipkema <martijn@entmoot.nl>
Cc: David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041017201118.GQ7468@marowsky-bree.de>
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <5d6b657504101707175aab0fcb@mail.gmail.com> <20041017150509.GC10280@mark.mielke.cc> <5d6b65750410170840c80c314@mail.gmail.com> <000801c4b46f$b62034b0$161b14ac@boromir> <5d6b65750410171033d9d83ab@mail.gmail.com> <002b01c4b483$b2bef130$161b14ac@boromir> <5d6b657504101712336468303c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d6b657504101712336468303c@mail.gmail.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-10-17T21:33:27, Buddy Lucas <buddy.lucas@gmail.com> wrote:

> You concluded from this that, if select() says a descriptor is
> readable, the subsequent recvmsg() must not block. The point is, from
> your quote I cannot deduct anything but: a recvmsg() on a descriptor
> that is readable must not block -- which makes perfect sense.
> 
> But unless POSIX also says something about the conservability of
> "readability" of descriptors, specifically in between select() and
> recvmsg(), your conclusion is just wrong.

What kind of idiotic (and most of all, wrong) hairsplitting are you
doing here, for heaven's sake? That's obviously exactly what the
standard implies.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

