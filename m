Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266610AbUG0TKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266610AbUG0TKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266586AbUG0TKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:10:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:59872 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266605AbUG0THI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:07:08 -0400
Date: Tue, 27 Jul 2004 12:05:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pasi Valminen <okun@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Remotely triggered kernel panic on PPPoE + IPv6 enabled linux
 boxes
Message-Id: <20040727120529.456d8aeb.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0407271720390.4851@kekkonen.cs.hut.fi>
References: <Pine.GSO.4.58.0407271720390.4851@kekkonen.cs.hut.fi>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Somebody has been editing email headers again.  Please do reply-to-all
when working on the kernel).

Pasi Valminen <okun@niksula.hut.fi> wrote:
>
> > I can trigger a kernel panic from a remote host using tracepath6.
>  > First I connect to the internet using pppoe.
>  PPPoE is not needed to crash the kernel. Plain vanilla 2.6.7 will crash
>  just fine without it, seems like bringing up an ipv6 tunnel is enough.
>  Then just
> 
>  $ tracepath6 <your tunnel ipv6 endpoint>

These problems were allegedly fixed post-2.6.7.  Please retest using the
latest kernel from ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots
