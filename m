Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVFBNOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVFBNOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 09:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVFBNJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 09:09:59 -0400
Received: from mx.laposte.net ([80.245.62.11]:42871 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S261420AbVFBND0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 09:03:26 -0400
Subject: Re: [RFC] SPI core
From: Rui Sousa <rui.sousa@laposte.net>
To: Greg KH <greg@kroah.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>,
       dmitry pervushin <dpervushin@ru.mvista.com>,
       linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>
In-Reply-To: <20050602045145.GA7838@kroah.com>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
	 <20050531233215.GB23881@kroah.com>
	 <20050602040655.GE4906@jupiter.solarsys.private>
	 <20050602045145.GA7838@kroah.com>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 15:02:35 +0200
Message-Id: <1117717356.5794.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, 2005-06-01 at 21:51 -0700, Greg KH wrote:
> On Thu, Jun 02, 2005 at 12:06:55AM -0400, Mark M. Hoffman wrote:
> > * Greg KH <greg@kroah.com> [2005-05-31 16:32:15 -0700]:
> > > This code is _very_ close to just a copy of the i2c core code.  Why
> > > duplicate it and not work with the i2c people instead?
> > 
> > It was discussed briefly on the lm-sensors mailing list [1].  I didn't 
> > reply at the time, but I do agree that SPI and I2C/SMBus are different
> > enough to warrant independent subsystems.
> 
> Independant is fine.  But direct copies, including making the same
> mistakes (i2c dev interface, i2c driver model mess) isn't :)

I have also worked on a(nother) SPI layer implementation. Like Dmitry, I
ended up following closely the i2c implementation, so, I'm curious to
know more details on what you call "i2c driver model mess".

> thanks,
> 
> greg k-h

Thanks,

Rui


