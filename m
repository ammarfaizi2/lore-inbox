Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264802AbTIDIOE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 04:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264805AbTIDIOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 04:14:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:10680 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264802AbTIDIOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 04:14:02 -0400
Date: Thu, 4 Sep 2003 01:12:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@redhat.com>
cc: Christoph Hellwig <hch@lst.de>, <paulus@samba.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <20030904010940.5fa0e560.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0309040111290.20151-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, David S. Miller wrote:
> 
> My suggestion is to just pass a resource and an offset to ioremap().

Actually, my suggestion right now is to ignore the issue, and let the 
current ppc440x code stand as-is. After all, it works, and it does what 
the ppc people want. We may at some point switch over _all_ ioremap users, 
but there is no real reason to do so right now.

		Linus

