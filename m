Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270416AbTGSB2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 21:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270428AbTGSB2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 21:28:34 -0400
Received: from mail.kroah.org ([65.200.24.183]:25508 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270416AbTGSB2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 21:28:33 -0400
Date: Fri, 18 Jul 2003 16:32:41 -0700
From: Greg KH <greg@kroah.com>
To: Christian Axelsson <smiler@lanil.mine.nu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [2.6.0-test1-mm1] Compile varnings
Message-ID: <20030718233241.GJ1583@kroah.com>
References: <1058387502.13489.2.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058387502.13489.2.camel@sm-wks1.lan.irkk.nu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 10:31:42PM +0200, Christian Axelsson wrote:
> Here is an i2c related warning:
> 
> CC      drivers/i2c/i2c-dev.o
> drivers/i2c/i2c-dev.c: In function `show_dev':
> drivers/i2c/i2c-dev.c:121: warning: unsigned int format, different type
> arg (arg 3)

I've posted a patch to fix this warning.  Look in the archives.

thanks,

greg k-h
