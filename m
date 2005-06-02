Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVFBEHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVFBEHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 00:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVFBEHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 00:07:12 -0400
Received: from smtp-relay.dca.net ([216.158.48.66]:61099 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S261331AbVFBEHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 00:07:05 -0400
Date: Thu, 2 Jun 2005 00:06:55 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Greg KH <greg@kroah.com>
Cc: dmitry pervushin <dpervushin@ru.mvista.com>, linux-kernel@vger.kernel.org,
       lm-sensors <lm-sensors@lm-sensors.org>
Subject: Re: [RFC] SPI core
Message-ID: <20050602040655.GE4906@jupiter.solarsys.private>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru> <20050531233215.GB23881@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531233215.GB23881@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Dmitry:

> On Tue, May 31, 2005 at 08:09:16PM +0400, dmitry pervushin wrote:
> > In order to support the specific board, we have ported the generic SPI
> > core to the 2.6 kernel. This core provides basic API to create/manage
> > SPI devices like the I2C core does. We need to continue providing
> > support of SPI devices and would like to maintain the SPI subtree. It
> > would be nice if SPI core patch were applied to the vanilla kernel.
> > I2C people do not like to mainain this code as well as I2C, so...

* Greg KH <greg@kroah.com> [2005-05-31 16:32:15 -0700]:
> What do you mean by this?  Which i2c people?

(...)

* Greg KH <greg@kroah.com> [2005-05-31 16:32:15 -0700]:
> This code is _very_ close to just a copy of the i2c core code.  Why
> duplicate it and not work with the i2c people instead?

It was discussed briefly on the lm-sensors mailing list [1].  I didn't 
reply at the time, but I do agree that SPI and I2C/SMBus are different
enough to warrant independent subsystems.

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2005-May/012385.html

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

