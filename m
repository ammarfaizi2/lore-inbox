Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269963AbUJNEPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269963AbUJNEPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 00:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269973AbUJNEP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 00:15:29 -0400
Received: from asav1.lyse.net ([213.167.96.68]:52932 "EHLO asav1.lyse.net")
	by vger.kernel.org with ESMTP id S269963AbUJNENe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 00:13:34 -0400
From: Alexander Wigen <alex@wigen.net>
To: Greg KH <greg@kroah.com>
Subject: Re: pl2303/usb-serial driver problem in 2.4.27-pre6
Date: Thu, 14 Oct 2004 14:06:58 +0000
User-Agent: KMail/1.7
Cc: LKML <linux-kernel@vger.kernel.org>
References: <416A6CF8.5050106@kharkiv.com.ua> 
	<200410131932.28896.alex@wigen.net> <20041013174251.GB17291@kroah.com>
In-Reply-To: <20041013174251.GB17291@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410141406.58960.alex@wigen.net>
X-imss-version: 2.7
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:21 M:1 S:5 R:5
X-imss-settings: Baseline:4 C:4 M:4 S:3 R:3 (1.0000 4.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 October 2004 17:42, Greg KH wrote:
> On Wed, Oct 13, 2004 at 07:32:28PM +0000, Alexander Wigen wrote:
> > May I add that I have some problems with a pl2303 GPS device which causes
> > kernel panics when I pull it out of the USB port.
> >
> > I don't know if it can be related, the device works fine until I unplug
> > it.
>
> On what kernel version do you have these problems?

I had the problem on two laptops and a stationary machine running 2.4.20. I 
dug out the old gps device and am happy to say the problem is gone on 
2.6.8.1. I don't have a 2.4 kernel handy so I can't say if the problem is 
still present in the 2.4 branch.

Cheers
Alexander Wigen
-- 
Homepage: http://www.wigen.net   Mail: alex@wigen.net
Why is the time of day with the slowest traffic called rush hour?
