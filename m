Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVASX1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVASX1C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVASX0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:26:09 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:27612 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261976AbVASXZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:25:14 -0500
Date: Wed, 19 Jan 2005 15:23:12 -0800
From: Greg KH <greg@kroah.com>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Simone Piunno <pioppo@ferrara.linux.it>, Jonas Munsin <jmunsin@iki.fi>,
       djg@pdp8.net
Subject: Re: [PATCH 2.6] I2C: Allow it87 pwm reconfiguration
Message-ID: <20050119232312.GB5909@kroah.com>
References: <20050113232904.GC2458@kroah.com> <g7Idbr9m.1105713630.9207120.khali@localhost> <20050115163045.2e636632.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115163045.2e636632.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 04:30:45PM +0100, Jean Delvare wrote:
> Quoting myself:
> 
> > As soon as you will have confirmed that everything worked as expected,
> > Jonas and I will provide a patch adding a pwm polarity reconfiguration
> > module parameter for you to test. This should give you access to the
> > PWM features of your it87 chip again, but in a safe way for a change
> > ;)
> 
> Here comes this patch. The new "fix_pwm_polarity" module parameter
> allows one to force the it87 chip reconfiguration. This is only
> supported in the case the original PWM configuration is suspected to be
> bogus, and only if we think that reconfiguring the chip is safe.
> 
> I wish to thank Rudolf Marek and Jonas Munsin again for their testing
> and review of my code.
> 
> Greg, please apply, thanks.

Applied, thanks.

greg k-h
