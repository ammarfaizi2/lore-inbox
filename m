Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVB1HAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVB1HAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 02:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVB1G7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 01:59:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:18588 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261512AbVB1G6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 01:58:09 -0500
Date: Sun, 27 Feb 2005 22:39:54 -0800
From: Greg KH <greg@kroah.com>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050228063954.GB23595@kroah.com>
References: <42225A47.3060206@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42225A47.3060206@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 06:39:51PM -0500, Wen Xiong wrote:
> This patch is for jsm_proc.c and includes the functions relating to 
> /proc/jsm entry.

No, don't add new /proc stuff.  Use sysfs, and if you want to spit out
more data, use debugfs.

What is the need for these files?

thanks,

greg k-h 
