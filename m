Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbUKIPWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUKIPWT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 10:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUKIPWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 10:22:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:50614 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261554AbUKIPWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 10:22:04 -0500
Date: Tue, 9 Nov 2004 07:21:45 -0800
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [BK PATCH] I2C update for 2.6.10-rc1
Message-ID: <20041109152145.GB27269@kroah.com>
References: <20041109052229.GA5117@kroah.com> <vYBFH9gE.1099992539.9943000.khali@gcu.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vYBFH9gE.1099992539.9943000.khali@gcu.info>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 10:29:00AM +0100, Jean Delvare wrote:
> 
> Hi Greg,
> 
> >Greg Kroah-Hartman:
> >  o I2C: delete normal_i2c_range logic from sensors as there are no more
> >         users
> >  o I2C: moved from all sensor drivers from normal_i2c_range to normal_i2c
> >  o I2C: fix i2c_detect to allow NULL fields in adapter address structure
> >  o I2C: remove normal_isa_range from I2C sensor drivers, as it's not used
> >  o I2C: remove ignore_range from I2C sensor drivers, as it's not used
> >  o I2C: remove probe_range from I2C sensor drivers, as it's not used
> 
> I'm very happy with that :) A documentation update will be needed though.

Doh, ok, I'll go do that, forgot that...

> Also, while we're at it, is there any reason why I2C_CLIENT_END and
> I2C_CLIENT_ISA_END are two different constants?

unsigned short vs unsigned int, right?

thanks,

greg k-h
