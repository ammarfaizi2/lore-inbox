Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269251AbUJQSID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269251AbUJQSID (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 14:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269252AbUJQSIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 14:08:02 -0400
Received: from gate.in-addr.de ([212.8.193.158]:39889 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S269251AbUJQSGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 14:06:50 -0400
Date: Sun, 17 Oct 2004 20:06:29 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Buddy Lucas <buddy.lucas@gmail.com>, Jesper Juhl <juhl-lkml@dif.dk>
Cc: David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041017180629.GO7468@marowsky-bree.de>
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <5d6b657504101707175aab0fcb@mail.gmail.com> <20041017150509.GC10280@mark.mielke.cc> <5d6b65750410170840c80c314@mail.gmail.com> <Pine.LNX.4.61.0410171921440.2952@dragon.hygekrogen.localhost> <5d6b65750410171104320bc6a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d6b65750410171104320bc6a8@mail.gmail.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-10-17T20:04:21, Buddy Lucas <buddy.lucas@gmail.com> wrote:

> [ snip ]
> 
> Also note the examples that Stevens gives. For instance, he explicitly
> checks for EWOULDBLOCK after a read on a nonblocking fd that has been
> reported readable by select().

The specs don't disagree with that. On a O_NONBLOCK socket, that is
allowed.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

