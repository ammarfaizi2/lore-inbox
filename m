Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWAOSHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWAOSHN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 13:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWAOSHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 13:07:13 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:13441 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932122AbWAOSHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 13:07:11 -0500
Date: Sun, 15 Jan 2006 10:11:17 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: stable@kernel.org, Evgeniy <dushistov@mail.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [STABLE] Fix oops in ufs_fill_super at mount time
Message-ID: <20060115181117.GM3335@sorel.sous-sol.org>
References: <20060115120252.GA13135@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060115120252.GA13135@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexey Dobriyan (adobriyan@gmail.com) wrote:
> From: Evgeniy <dushistov@mail.ru>
> 
> There's a lack of parenthesis in fs/ufs/utils.h, so instead of the 512th
> byte of buffer, the usb2 pointer will point to the nth structure of type
> ufs_super_block_second.

Thanks Alexey, this one's already queued for the next -stable.
-chris
