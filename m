Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270194AbTGaRiA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270468AbTGaRgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:36:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:45788 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270194AbTGaRg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:36:29 -0400
Date: Thu, 31 Jul 2003 10:36:24 -0700
From: Greg KH <greg@kroah.com>
To: Flameeyes <daps_mls@libero.it>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2, sensors and sysfs
Message-ID: <20030731173624.GB3644@kroah.com>
References: <1059669362.23100.12.camel@laurelin> <20030731165056.GA3622@kroah.com> <1059670884.23098.18.camel@laurelin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059670884.23098.18.camel@laurelin>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 07:01:24PM +0200, Flameeyes wrote:
> On Thu, 2003-07-31 at 18:50, Greg KH wrote:
> > What sensor drivers are you using in 2.4?  Are these drivers even
> > present in 2.6?  Remember, a lot of them have not been ported yet.
> The same, i2c-viapro and via686a, and they works well for mainboard, cpu
> and system temperatures, and also for fans' rpms.

Ok, what does:
	tree /sys/bus/i2c/
show when the drivers are loaded?

Also, what does:
	tree /sys/class/i2c_adapter
show?

thanks,

greg k-h
