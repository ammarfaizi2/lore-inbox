Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTLDBSF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbTLDBSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:18:05 -0500
Received: from mail.kroah.org ([65.200.24.183]:24982 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262827AbTLDBSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:18:03 -0500
Date: Wed, 3 Dec 2003 17:13:57 -0800
From: Greg KH <greg@kroah.com>
To: Fredrik Tolf <fredrik@dolda2000.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is hotplug a kernel helper?
Message-ID: <20031204011357.GA22506@kroah.com>
References: <16334.31260.278243.22272@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16334.31260.278243.22272@pc7.dolda2000.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 01:04:44AM +0100, Fredrik Tolf wrote:
> If you don't mind me asking, I would like to know why the kernel calls
> a usermode helper for hotplug events? Wouldn't a chrdev be a better
> solution (especially considering that programs like magicdev could
> listen in to it as well)? 

Please see the archives for why this is, it's been argued many times.

> Correct me if I'm wrong, but the kobject code never does check the
> return value from the usermode helper, right?

That is correct.

thanks,

greg k-h
