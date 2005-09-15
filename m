Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965261AbVIOEXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbVIOEXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 00:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965262AbVIOEXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 00:23:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17541 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965261AbVIOEXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 00:23:10 -0400
Date: Wed, 14 Sep 2005 21:22:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: dada1@cosmosbay.com, sonny@burdell.org, linux-kernel@vger.kernel.org
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
In-Reply-To: <20050914.210640.63539596.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0509142117150.26803@g5.osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
 <20050913063359.GA29715@kevlar.burdell.org> <43267A00.1010405@cosmosbay.com>
 <20050914.210640.63539596.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Sep 2005, David S. Miller wrote:
> 
> Why not just remember the lowest available free slot and start each
> bitmap search there?  This is a quite common technique.

Ehh. That's what "files->next_fd" is (well, now it's in the fdt
structure).

		Linus
