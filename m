Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUBSVuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267342AbUBSVuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:50:08 -0500
Received: from mail.kroah.org ([65.200.24.183]:5325 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267314AbUBSVuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:50:01 -0500
Date: Thu, 19 Feb 2004 13:49:51 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sys_device_[un]register() are not syscalls
Message-ID: <20040219214951.GA15338@kroah.com>
References: <20040213080753.12af00bd.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213080753.12af00bd.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 08:07:53AM -0800, Randy.Dunlap wrote:
> 
> 
> sys_xyz() names in Linux are all syscalls... except for
> sys_device_register() and sys_device_unregister().
> 
> This patch renames them so that the sys_ namespace is once
> again used only by syscalls.
> 
> Comments?

Looks good, I've applied this to my trees, and will send it to Linus.

Thanks,

greg k-h
