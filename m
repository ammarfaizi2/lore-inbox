Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVCOFi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVCOFi4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVCOFiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:38:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:26602 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262267AbVCOFim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:38:42 -0500
Date: Mon, 14 Mar 2005 21:38:27 -0800
From: Greg KH <greg@kroah.com>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Message-ID: <20050315053827.GA13337@kroah.com>
References: <4235BC29.2060009@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4235BC29.2060009@lougher.demon.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 04:30:33PM +0000, Phillip Lougher wrote:
> +typedef unsigned int		squashfs_block;
> +typedef long long		squashfs_inode;

Try using u32 and u64 instead.

> +typedef unsigned int		squashfs_uid;

Why is this a typedef?

> +
> +typedef struct squashfs_super_block {

Don't typedef structures, it's not the kernel way.

thanks,

greg k-h
