Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbVLMXBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbVLMXBL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbVLMXBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:01:11 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30355
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030321AbVLMXBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:01:09 -0500
Date: Tue, 13 Dec 2005 15:00:54 -0800 (PST)
Message-Id: <20051213.150054.130520681.davem@davemloft.net>
To: matthew@wil.cx
Cc: hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] sanitize building of fs/compat_ioctl.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051213225347.GT9286@parisc-linux.org>
References: <20051213173434.GP9286@parisc-linux.org>
	<20051213.145109.20744871.davem@davemloft.net>
	<20051213225347.GT9286@parisc-linux.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <matthew@wil.cx>
Date: Tue, 13 Dec 2005 15:53:47 -0700

> On Tue, Dec 13, 2005 at 02:51:09PM -0800, David S. Miller wrote:
> > What do you really still need it for at this point?
> 
> PPP.

Please show me offline how PPP needs this in a way that
can't be solved by ->compat_ioctl() or similar.  Thanks.
I looked at arch/parisc/kernel/ioctl32.c and didn't see
anything obvious.
