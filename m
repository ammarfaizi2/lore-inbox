Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275563AbTHNVcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 17:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275576AbTHNVcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 17:32:35 -0400
Received: from mail.kroah.org ([65.200.24.183]:29116 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275563AbTHNVcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 17:32:33 -0400
Date: Thu, 14 Aug 2003 14:32:42 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.0-test3]bugfix for initialization bug in adm1021 driver
Message-ID: <20030814213242.GA4058@kroah.com>
References: <1060731495.11264.8.camel@vmhack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060731495.11264.8.camel@vmhack>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 04:38:13PM -0700, Rusty Lynch wrote:
> While initializing the adm1021 device, the driver is performing a conversion
> from fixed point to Celcius on values that were declaired as Celcius.  On
> my Dell Precision 220 this results in a shutdown after a couple of minutes
> running.
> 
> This is a very simple patch against the 2.6.0-test3 tree that just removes the
> conversion.

Applied, thanks.

Next time you might want to CC: me to make sure I catch this.

greg k-h
