Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbVLMWxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbVLMWxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVLMWxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:53:49 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:65197 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1030282AbVLMWxs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:53:48 -0500
Date: Tue, 13 Dec 2005 15:53:47 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: "David S. Miller" <davem@davemloft.net>
Cc: hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] sanitize building of fs/compat_ioctl.c
Message-ID: <20051213225347.GT9286@parisc-linux.org>
References: <20051213172325.GC16392@lst.de> <20051213173434.GP9286@parisc-linux.org> <20051213.145109.20744871.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213.145109.20744871.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 02:51:09PM -0800, David S. Miller wrote:
> From: Matthew Wilcox <matthew@wil.cx>
> Date: Tue, 13 Dec 2005 10:34:34 -0700
> 
> > The 64-bit code doesn't compile because Andi keeps blocking the
> > is_compat_task() stuff.
> 
> The one place where I ever thought that was necessary, the
> USB async userspace I/O operation stuff, was solved much more
> cleanly with ->compat_ioctl() file_operations handlers.
> 
> What do you really still need it for at this point?

PPP.
