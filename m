Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVIWNHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVIWNHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 09:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVIWNHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 09:07:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:36512 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750961AbVIWNHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 09:07:20 -0400
Date: Fri, 23 Sep 2005 06:06:58 -0700
From: Greg KH <greg@kroah.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, torvalds@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc2: USB storage-related #GP on x86-64
Message-ID: <20050923130658.GA11908@kroah.com>
References: <200509231502.02344.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509231502.02344.rjw@sisk.pl>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 03:02:01PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> I've just triggered a general protection fault on Asus L5D (x86-64) by
> unplugging a USB floppy.

Can you try the latest -git snapshots?  The scsi changes that should
have fixed this went in after -rc2.

Linus, this is hitting a lot of people that are testing, can you release
a -rc3 anytime soon?

thanks,

greg k-h
