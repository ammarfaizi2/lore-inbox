Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWIJAj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWIJAj0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 20:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWIJAj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 20:39:26 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:608 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965060AbWIJAjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 20:39:25 -0400
Date: Sat, 9 Sep 2006 17:39:22 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Drake <dsd@gentoo.org>,
       akpm@osdl.org, torvalds@osdl.org, sergio@sergiomb.no-ip.org,
       jeff@garzik.org, bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       harmon@ksu.edu, len.brown@intel.com, vsu@altlinux.ru, liste@jordet.net
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
Message-ID: <20060910003922.GA8147@tuatara.stupidest.org>
References: <20060907223313.1770B7B40A0@zog.reactivated.net> <1157811641.6877.5.camel@localhost.localdomain> <4502D35E.8020802@gentoo.org> <1157817836.6877.52.camel@localhost.localdomain> <45033370.8040005@gentoo.org> <1157848272.6877.108.camel@localhost.localdomain> <20060910002112.GA20672@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910002112.GA20672@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 05:21:12PM -0700, Greg KH wrote:

> So why isn't acpi handling all of this for us?

for some people it does...

> Do people not want to use acpi for some reason?

I was told that in the past VIA has buggy/broken ACPI, so we need to
figure out what ACPI workaround Windows has and implement that (or
maybe they do it in the driver(s)?)
