Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWBNKHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWBNKHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWBNKHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:07:22 -0500
Received: from mx0.towertech.it ([213.215.222.73]:14316 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1030248AbWBNKHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:07:22 -0500
Date: Tue, 14 Feb 2006 11:07:13 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] RTC subsystem, class
Message-ID: <20060214110713.5600a427@inspiron>
In-Reply-To: <20060214090253.GA32597@linux-sh.org>
References: <20060213225416.865078000@towertech.it>
	<20060213225417.074551000@towertech.it>
	<20060214090253.GA32597@linux-sh.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006 11:02:53 +0200
Paul Mundt <lethal@linux-sh.org> wrote:

> On Mon, Feb 13, 2006 at 11:54:17PM +0100, Alessandro Zummo wrote:
> > --- linux-rtc.orig/drivers/Makefile	2006-02-13 19:34:35.000000000 +0100
> > +++ linux-rtc/drivers/Makefile	2006-02-13 19:35:30.000000000 +0100
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
> >  obj-$(CONFIG_GAMEPORT)		+= input/gameport/
> >  obj-$(CONFIG_INPUT)		+= input/
> >  obj-$(CONFIG_I2O)		+= message/
> > +obj-y				+= rtc/
> >  obj-$(CONFIG_I2C)		+= i2c/
> >  obj-$(CONFIG_W1)		+= w1/
> >  obj-$(CONFIG_HWMON)		+= hwmon/
> 
> Why is this obj-y? obj-$(CONFIG_RTC_CLASS) perhaps?

 there are a couple of primitives that are used
 in different places in the kernel, even when rtc class
 is not in use. mostly time struture conversion
 and validation.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

