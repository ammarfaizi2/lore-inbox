Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVCHHB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVCHHB0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVCHG7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:59:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:65184 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261865AbVCHGzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:55:41 -0500
Date: Mon, 7 Mar 2005 22:42:11 -0800
From: Greg KH <greg@kroah.com>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050308064211.GE17022@kroah.com>
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com> <20050228065534.GC23595@kroah.com> <4228CE5C.9010207@us.ltcfwd.linux.ibm.com> <20050305064445.GA8447@kroah.com> <422CDA58.5000506@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422CDA58.5000506@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 05:48:56PM -0500, Wen Xiong wrote:
> Since some tools in Digi company need these new ioctls to access device 
> driver. I still keep these new ioctls.

What tools?  What are they used for?  Why do they need them?  Why can't
they just use the sysfs files?  

As the driver isn't in the kernel tree, there should not be any users
expecting these ioctls to be around, right?

thanks,

greg k-h
