Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVCIUBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVCIUBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVCIUAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:00:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:28898 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261964AbVCITva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:51:30 -0500
Date: Wed, 9 Mar 2005 11:51:10 -0800
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050309195110.GA28312@kroah.com>
References: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D9EB@minimail.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D9EB@minimail.digi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 01:35:41PM -0600, Kilau, Scott wrote:
> As it stands today, your requirement appears to be that she needs
> to yank all diags ioctls and sysfs files before the driver can make
> it into the kernel sources.

Not all sysfs files, sysfs files are fine, as long as they are
implemented properly, and are there for things that "make sense".

But yes, it should would be easier to accept the driver if the ioctls
were not there :)

thanks,

greg k-h
