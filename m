Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbUKLTQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUKLTQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUKLTPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:15:08 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:61872 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261608AbUKLTO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:14:57 -0500
Date: Fri, 12 Nov 2004 11:14:49 -0800
From: Greg KH <greg@kroah.com>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/bus/i2c is missing
Message-ID: <20041112191448.GA417@kroah.com>
References: <20041112141202.GA19781@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041112141202.GA19781@beton.cybernet.src>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 02:12:02PM +0000, Karel Kulhavy wrote:
> Hello
> 
> linux 2.6.8.1
> 
> I insmoded i2c-parport and pcf8591 modules and i2c-1 appeared in my /dev
> (previously, only i2c-0 was there):
> 
> 	clock@oberon:~$ ls /dev/i2* 
> 	/dev/i2c-0  /dev/i2c-1
> 	
> 	/dev/i2c:
> 	0  1
> 
> /usr/src/linux/Documentation/i2c says "You can
> examine /proc/bus/i2c to see what number corresponds to which adapter."
> I don't have any /proc/i2c:

That is outdated, and you should look in /sys/class/i2c-dev/.  I'll go
change that documentation now.

thanks,

greg k-h
