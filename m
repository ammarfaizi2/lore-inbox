Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbTJIVXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbTJIVXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:23:11 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:5016 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S262588AbTJIVXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:23:07 -0400
Subject: Re: Call trace when rmmod'ing saa7134 and error when compiling
	static
From: Stian Jordet <liste@jordet.nu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
In-Reply-To: <20031009210805.GB12266@kroah.com>
References: <1065708534.737.2.camel@chevrolet.hybel>
	 <20031009210805.GB12266@kroah.com>
Content-Type: text/plain
Message-Id: <1065734600.6237.0.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Oct 2003 23:23:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 09.10.2003 kl. 23.08 skrev Greg KH:
> On Thu, Oct 09, 2003 at 04:08:54PM +0200, Stian Jordet wrote:
> > Hello,
> > 
> > when I try to rmmod the saa7134 module from kernel 2.6.0-test7, I get
> > this call trace:
> > 
> > Device class 'i2c-1' does not have a release() function, it is broken
> > and must be fixed.
> 
> This is when you remove the i2c-dev module, right?  Yeah, I know about
> the problem and will fix it.

I have no idea, I just "rmmod saa7134" :)

Best regards,
Stian

