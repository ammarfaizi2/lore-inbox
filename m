Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTE3QGV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 12:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbTE3QGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 12:06:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:28823 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263766AbTE3QGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 12:06:21 -0400
Date: Thu, 29 May 2003 23:26:34 -0700
From: Greg KH <greg@kroah.com>
To: John Covici <covici@ccs.covici.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what happened to i2c-proc
Message-ID: <20030530062634.GA16471@kroah.com>
References: <m3d6i3avnk.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3d6i3avnk.fsf@ccs.covici.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 12:22:23PM -0400, John Covici wrote:
> I am trying to compile appropriate modules for lm sensors in 2.5.70,
> but there seems to be no way to configure i2c-proc -- it seems to be
> there for other architectures, but not for i386.

i2c-proc is no longer a separate compile option.  The i2c interface is
now through sysfs, not /proc for 2.5.

thanks,

greg k-h
