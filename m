Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWESRTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWESRTv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWESRTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:19:51 -0400
Received: from [212.33.165.255] ([212.33.165.255]:24339 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751382AbWESRTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:19:51 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] namespaces: Introduction
Date: Fri, 19 May 2006 20:17:32 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605192017.32401.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin wrote:
> I have a practical proposal.
> We can start with presenting and merging the most interesting part,
> network containers.  We discuss details, possible approaches, and related
> subsystems, until networking is finished to its utmost detail.
> This will create an example of virtualization of a non-trivial subsystem,
> and we will have to agree on basic principles of virtualization of related
> subsystems like proc.
>
> Virtualization of networking presents a lot of challenges and
> decision-making points with respect to user-visible interfaces: proc,
> sysctl, netlink events (and netlink sockets themselves), and so on.  This
> code will also become immediately useful as an improvement over chroot.
> I am sure that when we come to a mutually acceptable solution with respect
> to networking, virtualization of all other subsystems can be implemented
> and merged without many questions.
>
> What do people think about this plan?

Exactly what I thought too, and in general always the best way to move 
forward, i.e: "slowly but surely" instead of "big bang".

This would of course imply, that even this subsystem should be kept as 
minimalistic as possible, to avoid any side-effects and to just concentrate 
on the crux of the problem.

Thanks!

--
Al

