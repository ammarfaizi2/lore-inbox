Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVERDlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVERDlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 23:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVERDlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 23:41:10 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:8250 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262073AbVERDk4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 23:40:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z9gAdrnzqlo0GSJQhQaJlN+W412CEJwZoGxQ0aDaXVOMgbNVjdQbGUVTF6fOoHVf8tfZY4id0lXYPm9bKniT053CRD77MnONFm5tgclpR02vRBM2lVm00M1is/KmxJ0DAXxMXi5FT7BbU12N6BBTijfS/twlZo+mSMwLf5X6HWU=
Message-ID: <253818670505172040f303003@mail.gmail.com>
Date: Tue, 17 May 2005 23:40:55 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Raj Gupta <gupta.raj@gmail.com>
Subject: Re: [lm-sensors] Re: [PATCH 2.6.12-rc4 14/15] include/linux/i2c-sysfs.h: i2c sensor_device_attribute and macros
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
In-Reply-To: <393213cd05051720137cc562b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2538186705051703463587a54@mail.gmail.com>
	 <253818670505171959f5cecb@mail.gmail.com>
	 <393213cd05051720137cc562b0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You will want to start a new thread (change the subject line) since
this post is completely unrelated to the patch it references.

As for your question I'm probably not the best person to ask, about
those topics, but if you are looking for a kernel reference
http://lxr.linux.no/ is invaluable. Linux Device Drivers 3 looks like
a good reference for driver coding too, I just bought it. Greg KH
would certainly recommend it to you since he is a co-author ;-).

Good luck,
Yani

On 5/17/05, Raj Gupta <gupta.raj@gmail.com> wrote:
> Hi,
> I am joined as reseach scholar and going to work in the feild of wireless
> technology in sensors with use of linux OS. Can someone suggest me good
> material for tutorial on linux kernel and implementation of wireless
> technology in linux middleware
> 
>  On 5/17/05, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> >
> > Oops..I caught this simple typo while compile testing the adm1026
> > patch with everything, but it looks like I forgot to update the patch,
> > here is the corrected version (just adding the missing '=' ):
> >
> > Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
> >
> > Yani
> >
> > On 5/17/05, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> > > This patch creates a new header with a potential standard i2c sensor
> > > attribute type (which simply includes an int representing the sensor
> > > number/index) and the associated macros, SENSOR_DEVICE_ATTR to define
> > > a static attribute and to_sensor_dev_attr to get a
> > > sensor_device_attribute reference from an embedded device_attribute
> > > reference.
> > >
> > > Please see the next patch to see how these can be used.
> > >
> > > Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
> > >
> > > ---
> > >
> > >
> > >
> >
> >
> >
> 
> --
> thanks and regards
> Raj Gupta
> 
> M.S. Research Scholar,
> Residence, Distributed and Object Systems Lab.,
> 545 Sector 15 - I , Department of CS & E,
> Gurgaon - 122001, INDIA IIT Madras, Chennai - 600036,
> Ph: +91-124-2301918 Tamil Nadu, INDIA
> 9840623332 Ph: x5343 (Lab)
> Email: gupta.raj@gmail.com Email: rgupta@cs.iitm.ernet.in
> 
> "Some things you just don't talk about | Hold on tight and pray for the best
> "
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
