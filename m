Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVFBElp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVFBElp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 00:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVFBElo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 00:41:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:20194 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261509AbVFBEln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 00:41:43 -0400
Date: Wed, 1 Jun 2005 21:51:45 -0700
From: Greg KH <greg@kroah.com>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: dmitry pervushin <dpervushin@ru.mvista.com>, linux-kernel@vger.kernel.org,
       lm-sensors <lm-sensors@lm-sensors.org>
Subject: Re: [RFC] SPI core
Message-ID: <20050602045145.GA7838@kroah.com>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru> <20050531233215.GB23881@kroah.com> <20050602040655.GE4906@jupiter.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602040655.GE4906@jupiter.solarsys.private>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 12:06:55AM -0400, Mark M. Hoffman wrote:
> * Greg KH <greg@kroah.com> [2005-05-31 16:32:15 -0700]:
> > This code is _very_ close to just a copy of the i2c core code.  Why
> > duplicate it and not work with the i2c people instead?
> 
> It was discussed briefly on the lm-sensors mailing list [1].  I didn't 
> reply at the time, but I do agree that SPI and I2C/SMBus are different
> enough to warrant independent subsystems.

Independant is fine.  But direct copies, including making the same
mistakes (i2c dev interface, i2c driver model mess) isn't :)

thanks,

greg k-h
