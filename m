Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUEKUqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUEKUqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbUEKUqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:46:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:23951 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263645AbUEKUqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:46:23 -0400
Date: Tue, 11 May 2004 13:44:16 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Cc: Michael Hunold <hunold@convergence.de>
Subject: Re: [PATCH 2.6] Rename hardware monitoring I2C class
Message-ID: <20040511204415.GA23991@kroah.com>
References: <409923F7.7050101@convergence.de> <20040506213455.29154c51.khali@linux-fr.org> <20040509174820.5bc47686.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040509174820.5bc47686.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 05:48:20PM +0200, Jean Delvare wrote:
> Hi Greg, all,
> 
> Quoting myself:
> 
> > Mmm, I once proposed that I2C_ADAP_CLASS_SMBUS would be better renamed
> > I2C_ADAP_CLASS_SENSORS (so I2C_CLASS_SENSORS now). What about that? I
> > think it would be great to embed that change into your patch, so that
> > the name changes only once.
> > 
> > BTW, if HWMON is prefered to SENSORS, this is fine with me too, I
> > have no strong preference.
> 
> Below is a patch that does that. I finally went for HWMON. Yes, it's
> big, but it's actually nothing more than
> s/I2C_CLASS_SMBUS/I2C_CLASS_HWMON/ (thanks perl -wip :)).
> 
> Greg, can you please apply it on top of Michael's patch?

Applied, thanks.

greg k-h
