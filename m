Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267649AbUBTAzE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267636AbUBTAvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:51:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:38049 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267626AbUBTAvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:51:31 -0500
Date: Thu, 19 Feb 2004 16:23:28 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Tommi Virtanen <tv@tv.debian.net>, Leann Ogasawara <ogasawara@osdl.org>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] propogate errors from misc_register to caller
Message-ID: <20040220002328.GE16267@kroah.com>
References: <20040213102755.27cf4fcd.shemminger@osdl.org> <20040213112100.4f42abc2@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213112100.4f42abc2@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 11:21:00AM -0800, Stephen Hemminger wrote:
> The patch to check for / in class_device is not enough.
> The misc_register function needs to check return value of the things it calls!

Applied to my trees, thanks.

greg k-h
