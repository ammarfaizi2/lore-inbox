Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVCHDDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVCHDDW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVCHDAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 22:00:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:37519 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261314AbVCHC4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 21:56:22 -0500
Date: Mon, 7 Mar 2005 15:21:24 -0800
From: Greg KH <greg@kroah.com>
To: Jim Nelson <james4765@cwazy.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/13] speedtch: Clean up printk()'s in drivers/usb/atm/speedtch.c
Message-ID: <20050307232124.GB9159@kroah.com>
References: <20050305233712.7648.24364.93822@localhost.localdomain> <20050306055635.GA12662@kroah.com> <422AF521.6010609@cwazy.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422AF521.6010609@cwazy.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 07:18:41AM -0500, Jim Nelson wrote:
> Any other tips on how the usb printk()s should be formatted to maintain
> consistency?  Or some driver that I could use as an example?

Use dev_dbg() and friends.  That is the proper consistency.

thanks,

greg k-h
