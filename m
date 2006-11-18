Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755869AbWKRBAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbWKRBAh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 20:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756105AbWKRBAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 20:00:37 -0500
Received: from nlpi001.sbcis.sbc.com ([207.115.36.30]:42697 "EHLO
	nlpi001.sbcis.sbc.com") by vger.kernel.org with ESMTP
	id S1755869AbWKRBAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 20:00:36 -0500
X-ORBL: [67.117.73.34]
Date: Sat, 18 Nov 2006 03:00:23 +0200
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: Basic support for siemens sx1
Message-ID: <20061118010022.GQ6072@atomide.com>
References: <20061116170209.GA5544@elf.ucw.cz> <20061117175431.GD6072@atomide.com> <20061118003816.GA9187@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118003816.GA9187@elf.ucw.cz>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [061118 02:38]:
> Hi!
> 
> > * Pavel Machek <pavel@ucw.cz> [061116 19:04]:
> > > From: Vladimir Ananiev <vovan888@gmail.com>
> > > 
> > > This adds basic support for Siemens SX1. More patches are available,
> > > with video driver, mixer, and serial ports working. That is enough to
> > > do gsm calls with right userland.
> > 
> > Cool.
> 
> :-)
> 
> > > It would be nice to get basic patches merged to the -omap tree... do
> > > they look ok?
> > 
> > Yeah, looks good, except for the i2c part. Is Sofia really a TI PCF8574
> > i2c chip? In that case it could use the gpioexpander code.  
> > 
> > Anyways, let's plan on pushing this to linux-omap tree, then do the
> > changes for gpioexpander, and send that upstream too.
> 
> Works for me. I'll check with google to find out what sofia really is.

OK, I've pushed to linux-omap after separating USB and MMC code into
separate patches. Also did a bit more tabifying on the code.

BTW, PCF8574 .pdf is available on TI's site.

Regards,

Tony
