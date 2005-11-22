Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVKVCuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVKVCuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 21:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVKVCuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 21:50:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33163 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750777AbVKVCuL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 21:50:11 -0500
Date: Tue, 22 Nov 2005 02:50:09 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm2] net: Fix compiler-error on atyfb_base.c when !CONFIG_PCI
Message-ID: <20051122025009.GI27946@ftp.linux.org.uk>
References: <20051122022652.6806.10075.sendpatchset@thinktank.campus.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122022652.6806.10075.sendpatchset@thinktank.campus.ltu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 03:21:42AM +0100, Richard Knutsson wrote:
> From: Richard Knutsson <ricknu-0@student.ltu.se>
> 
> Fix compiler-error on atyfb_base.c when CONFIG_PCI not set.

NAK.  Please, don't introduce bogus objects.
