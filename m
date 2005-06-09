Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVFILGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVFILGC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 07:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVFILGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 07:06:02 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:34484 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S262346AbVFILFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 07:05:55 -0400
From: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: BUG in i2c_detach_client
Date: Thu, 9 Jun 2005 07:05:21 -0400
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, "Greg KH" <greg@kroah.com>,
       "Mark M. Hoffman" <mhoffman@lightlink.com>
References: <JctXv2LZ.1118303243.5186830.khali@localhost>
In-Reply-To: <JctXv2LZ.1118303243.5186830.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506090705.22196.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On June 9, 2005 03:47 am, Jean Delvare wrote:
> The reason why the bug triggered on Andrew (James Wade) is probably that
> hwmon_device_register() failed, due to an order problem in a Makefile.
> See http://lkml.org/lkml/2005/6/8/338, which has an explanation and a
> patch fixing it (I think).
Yup, the kernel now boots.

> This still doesn't explain why the error path triggers the BUG(), and
> although applying the aforementioned patch will probably get the driver
> working, I'd really like to understand what's going on there.
Ok, I'll keep playing around with the kernel to see what I can find out.

(and I'll take a look at
http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 as Andrew Morton
suggested)

Thanks,
Andrew
