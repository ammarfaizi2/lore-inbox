Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUA3TPl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbUA3TPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:15:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:31128 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263325AbUA3TPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:15:40 -0500
Date: Fri, 30 Jan 2004 11:14:53 -0800
From: Greg KH <greg@kroah.com>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: khubd crash on scanner disconnect
Message-ID: <20040130191453.GA7173@kroah.com>
References: <20040130173656.GA4570@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130173656.GA4570@merlin.emma.line.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 06:36:56PM +0100, Matthias Andree wrote:
> Hi,
> 
> I have just caught this khubd NULL dereference simply by unplugging my
> scanner. Kernel is a current 2.6.2-rc2 from BK, PNP enabled:

Known bug, don't use that module, it's OBSOLETED.  Use xscane and libusb
instead.

thanks,

greg k-h
