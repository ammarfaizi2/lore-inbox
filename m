Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbTDKVpd (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 17:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbTDKVpd (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 17:45:33 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:6349 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261830AbTDKVpc (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 17:45:32 -0400
Date: Fri, 11 Apr 2003 14:59:40 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C, compile error: via686a_attach_adapter()
Message-ID: <20030411215940.GY1821@kroah.com>
References: <200304111751.07679.ivg2@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304111751.07679.ivg2@cornell.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 05:51:02PM -0400, Ivan Gyurdiev wrote:
> : undefined reference to `i2c_detect'

Build the driver as a module, or apply the patch to
drivers/i2c/chips/Kconfig that I've posted to the list in the past few
days.

thanks,

greg k-h
