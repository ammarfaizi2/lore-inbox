Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933751AbWKQRzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933751AbWKQRzG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 12:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933754AbWKQRzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 12:55:06 -0500
Received: from nlpi012.sbcis.sbc.com ([207.115.36.41]:57066 "EHLO
	nlpi012.sbcis.sbc.com") by vger.kernel.org with ESMTP
	id S933751AbWKQRzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 12:55:04 -0500
X-ORBL: [67.117.73.34]
Date: Fri, 17 Nov 2006 19:54:32 +0200
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: Basic support for siemens sx1
Message-ID: <20061117175431.GD6072@atomide.com>
References: <20061116170209.GA5544@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116170209.GA5544@elf.ucw.cz>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Pavel Machek <pavel@ucw.cz> [061116 19:04]:
> From: Vladimir Ananiev <vovan888@gmail.com>
> 
> This adds basic support for Siemens SX1. More patches are available,
> with video driver, mixer, and serial ports working. That is enough to
> do gsm calls with right userland.

Cool.
 
> It would be nice to get basic patches merged to the -omap tree... do
> they look ok?

Yeah, looks good, except for the i2c part. Is Sofia really a TI PCF8574
i2c chip? In that case it could use the gpioexpander code.  

Anyways, let's plan on pushing this to linux-omap tree, then do the
changes for gpioexpander, and send that upstream too.

Regards,

Tony
