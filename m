Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTLLR5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 12:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTLLR5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 12:57:16 -0500
Received: from mail.kroah.org ([65.200.24.183]:42933 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261595AbTLLR5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 12:57:14 -0500
Date: Fri, 12 Dec 2003 09:56:57 -0800
From: Greg KH <greg@kroah.com>
To: Johannes Stezenbach <js@convergence.de>, sensors@stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11: i2c-dev.h for userspace
Message-ID: <20031212175656.GA2933@kroah.com>
References: <20031212145652.GA30747@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212145652.GA30747@convergence.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 03:56:52PM +0100, Johannes Stezenbach wrote:
> 
> I had some trouble compiling a userspace application
> which uses the I2C device interface (the DirectFB
> Matrox driver). Apparently some stuff has been removed
> from i2c-dev.h

Yes it has.  Do not use the kernel headers in your userspace
application.  If you need this interface, use the updated i2c-dev.h that
is in the lmsensors release.  That is the proper file.

thanks,

greg k-h
