Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbTDCRqV 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261520AbTDCRqV 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:46:21 -0500
Received: from palrel11.hp.com ([156.153.255.246]:61626 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261517AbTDCRqQ 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 12:46:16 -0500
Date: Thu, 3 Apr 2003 09:57:43 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: toshiba_fir and toshiba_old IRDA drivers broken on 4030cdt
Message-ID: <20030403175743.GA16885@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote :
> In 2.4.X, I'm able to get  IrDA working on 4030cdt. In 2.5.66,,
> toshiba_fir complains about interrupt test not passed at boot, and
> then just does not work; toshiba_old woks enough to do discovery, but
> ircomm communication is still not possible.
> 						Pavel

	I think this info was already passed to the driver
maintainers, but I heven't heard from them. You may want to just
disable the interrupt test (I think there is a flag) and try again.
	Good luck...

	Jean

