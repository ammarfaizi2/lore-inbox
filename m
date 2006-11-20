Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966213AbWKTR0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966213AbWKTR0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966239AbWKTR0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:26:24 -0500
Received: from nlpi029.sbcis.sbc.com ([207.115.36.58]:55771 "EHLO
	nlpi029.sbcis.sbc.com") by vger.kernel.org with ESMTP
	id S966213AbWKTR0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:26:23 -0500
X-ORBL: [67.117.73.34]
Date: Mon, 20 Nov 2006 17:26:09 +0000
From: Tony Lindgren <tony@atomide.com>
To: Vladimir <vovan888@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Basic support for siemens sx1
Message-ID: <20061120172609.GB4597@atomide.com>
References: <20061116170209.GA5544@elf.ucw.cz> <20061117175431.GD6072@atomide.com> <20061118003816.GA9187@elf.ucw.cz> <20061118010022.GQ6072@atomide.com> <ce55079f0611200056k19ab8b92p4aad189e6884e75@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce55079f0611200056k19ab8b92p4aad189e6884e75@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Vladimir <vovan888@gmail.com> [061120 08:57]:
> 2006/11/18, Tony Lindgren <tony@atomide.com>:
> >* Pavel Machek <pavel@ucw.cz> [061118 02:38]:
> >> Hi!
> >>
> >> > * Pavel Machek <pavel@ucw.cz> [061116 19:04]:
> >> > > From: Vladimir Ananiev <vovan888@gmail.com>
> >> > >
> >> > > This adds basic support for Siemens SX1. More patches are available,
> >> > > with video driver, mixer, and serial ports working. That is enough to
> >> > > do gsm calls with right userland.
> >> >
> >> > Cool.
> >>
> >> :-)
> >>
> >> > > It would be nice to get basic patches merged to the -omap tree... do
> >> > > they look ok?
> >> >
> >> > Yeah, looks good, except for the i2c part. Is Sofia really a TI PCF8574
> >> > i2c chip? In that case it could use the gpioexpander code.
> >> >
> >> > Anyways, let's plan on pushing this to linux-omap tree, then do the
> >> > changes for gpioexpander, and send that upstream too.
> >>
> >> Works for me. I'll check with google to find out what sofia really is.
> >
> >OK, I've pushed to linux-omap after separating USB and MMC code into
> >separate patches. Also did a bit more tabifying on the code.
> >
> >BTW, PCF8574 .pdf is available on TI's site.
> >
> >Regards,
> >
> >Tony
> >
> 
> Sofia is manufactured by Dialog and i didnt find any docs about it...
> And it is completely different from PCF8574, it is power controller IC.

OK, thanks for clarifying that.

Tony
