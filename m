Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTJIVIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTJIVIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:08:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:3302 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262569AbTJIVI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:08:29 -0400
Date: Thu, 9 Oct 2003 14:08:05 -0700
From: Greg KH <greg@kroah.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: Call trace when rmmod'ing saa7134 and error when compiling static
Message-ID: <20031009210805.GB12266@kroah.com>
References: <1065708534.737.2.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065708534.737.2.camel@chevrolet.hybel>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 04:08:54PM +0200, Stian Jordet wrote:
> Hello,
> 
> when I try to rmmod the saa7134 module from kernel 2.6.0-test7, I get
> this call trace:
> 
> Device class 'i2c-1' does not have a release() function, it is broken
> and must be fixed.

This is when you remove the i2c-dev module, right?  Yeah, I know about
the problem and will fix it.

thanks,

greg k-h
