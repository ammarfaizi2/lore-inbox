Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270359AbTHCEWq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 00:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270373AbTHCEWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 00:22:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:6859 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270359AbTHCEWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 00:22:45 -0400
Date: Sat, 2 Aug 2003 21:11:44 -0700
From: Greg KH <greg@kroah.com>
To: root@mauve.demon.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 pegasus USB ethernet system lockup.
Message-ID: <20030803041144.GA18501@kroah.com>
References: <200308030022.BAA03775@mauve.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308030022.BAA03775@mauve.demon.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 01:22:07AM +0100, root@mauve.demon.co.uk wrote:
> Occasionally I also get 
> Aug  1 01:47:37 mauve kernel: Debug: sleeping function called from invalid context at drivers/usb/core/hcd.c:1350

This is fixed in Linus's tree.

> I am unable to say if lights are flashing on the keyboard, as there are 
> no lights on the keyboard.

Can you use a serial debug console and/or the nmi watchdog to see if you
can capture where things went wrong?

thanks,

greg k-h
