Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265310AbUFRW6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUFRW6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFRWrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:47:53 -0400
Received: from mail.kroah.org ([65.200.24.183]:19133 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264527AbUFRWp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:45:59 -0400
Date: Fri, 18 Jun 2004 15:44:46 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Almenar <aalmenar@conectium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysfs directories...
Message-ID: <20040618224446.GA17482@kroah.com>
References: <20040618155117.0bffd01d@er-murazor.conectium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618155117.0bffd01d@er-murazor.conectium.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 03:51:17PM -0400, Adrian Almenar wrote:
> i was looking at /sys on my machine yesterday and i found something
> strange.
> 
> cd
> /sys/block/hda/device/block/device/block/device/block/device/block/...
> and that continues being almost infinite and recursive, it is normal
> ???

What does:
	ls -l /sys/block/hda

show?

thanks,

greg k-h
