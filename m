Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUEBG4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUEBG4V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 02:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUEBG4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 02:56:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:29338 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261668AbUEBG4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 02:56:19 -0400
Date: Sat, 1 May 2004 23:49:15 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, roms@lpg.ticalc.org, jb@technologeek.org
Subject: Re: [PATCH 2.6.6-rc3] Add class support to drivers/usb/misc/tiglusb.c
Message-ID: <20040502064915.GF3766@kroah.com>
References: <79660000.1083267538@dyn318071bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79660000.1083267538@dyn318071bld.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 12:38:58PM -0700, Hanna Linder wrote:
> +static int class_minor;

This will not work if you have multiple devices and unload the driver,
right?

thanks,

greg k-h
