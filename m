Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934021AbWKTI5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934021AbWKTI5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 03:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934022AbWKTI5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 03:57:07 -0500
Received: from nz-out-0102.google.com ([64.233.162.193]:61149 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S934021AbWKTI5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 03:57:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SbC+vQL3FyvVLJ+XjvzccrKu/ozhDeXTWlV0rzXnxdv22XPFPWf1AAGNR441PV/+btbvA/0O+Qm1KJTa7Ly3eEWXAYcIztRPEVHZsb5hIwQsmgn7dSD8Xvqxh7cxZ1ZTkQ+aMB3ye71WrlcdMk4LE06U9fYVulZq11/o1wyh/YA=
Message-ID: <ce55079f0611200056k19ab8b92p4aad189e6884e75@mail.gmail.com>
Date: Mon, 20 Nov 2006 11:56:59 +0300
From: Vladimir <vovan888@gmail.com>
To: "Tony Lindgren" <tony@atomide.com>
Subject: Re: Basic support for siemens sx1
Cc: "Pavel Machek" <pavel@ucw.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061118010022.GQ6072@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061116170209.GA5544@elf.ucw.cz>
	 <20061117175431.GD6072@atomide.com> <20061118003816.GA9187@elf.ucw.cz>
	 <20061118010022.GQ6072@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/11/18, Tony Lindgren <tony@atomide.com>:
> * Pavel Machek <pavel@ucw.cz> [061118 02:38]:
> > Hi!
> >
> > > * Pavel Machek <pavel@ucw.cz> [061116 19:04]:
> > > > From: Vladimir Ananiev <vovan888@gmail.com>
> > > >
> > > > This adds basic support for Siemens SX1. More patches are available,
> > > > with video driver, mixer, and serial ports working. That is enough to
> > > > do gsm calls with right userland.
> > >
> > > Cool.
> >
> > :-)
> >
> > > > It would be nice to get basic patches merged to the -omap tree... do
> > > > they look ok?
> > >
> > > Yeah, looks good, except for the i2c part. Is Sofia really a TI PCF8574
> > > i2c chip? In that case it could use the gpioexpander code.
> > >
> > > Anyways, let's plan on pushing this to linux-omap tree, then do the
> > > changes for gpioexpander, and send that upstream too.
> >
> > Works for me. I'll check with google to find out what sofia really is.
>
> OK, I've pushed to linux-omap after separating USB and MMC code into
> separate patches. Also did a bit more tabifying on the code.
>
> BTW, PCF8574 .pdf is available on TI's site.
>
> Regards,
>
> Tony
>

Sofia is manufactured by Dialog and i didnt find any docs about it...
And it is completely different from PCF8574, it is power controller IC.
