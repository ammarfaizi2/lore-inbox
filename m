Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUB0Ax7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbUB0Aw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:52:57 -0500
Received: from mail.kroah.org ([65.200.24.183]:53211 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261477AbUB0AsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:48:10 -0500
Date: Thu, 26 Feb 2004 16:48:05 -0800
From: Greg KH <greg@kroah.com>
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm4
Message-ID: <20040227004805.GC15075@kroah.com>
References: <20040225185536.57b56716.akpm@osdl.org> <403DB381.6060701@vgertech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403DB381.6060701@vgertech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 08:51:13AM +0000, Nuno Silva wrote:
> WARNING: /lib/modules/2.6.3-mm4/kernel/drivers/i2c/busses/i2c-elektor.ko needs unknown symbol cli
> WARNING: /lib/modules/2.6.3-mm4/kernel/drivers/i2c/busses/i2c-elektor.ko needs unknown symbol sti

Known issue.  If you enable CONFIG_BROKEN_ON_SMP then you will not see
this problem (as you will not be able to build the driver...)

thanks,

greg k-h
