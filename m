Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVLMRa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVLMRa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVLMRa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:30:59 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:31970 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751029AbVLMRa6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:30:58 -0500
Date: Tue, 13 Dec 2005 10:30:57 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/3] move rtc compat ioctl handling to fs/compat_ioctl.c
Message-ID: <20051213173057.GO9286@parisc-linux.org>
References: <20051213172312.GA16392@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213172312.GA16392@lst.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 06:23:12PM +0100, Christoph Hellwig wrote:
> parisc used COMPAT_IOCTL or generic w_long handlers for these whichce
> is wrong and can't work because the ioctls encode sizeof(unsigned long)
> in their ioctl number.  parisc also duplicated COMPAT_IOCTL entries for
> other rtc ioctls which I remove in this patch, too.

ACK.
