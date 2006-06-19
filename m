Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWFSUMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWFSUMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWFSUMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:12:13 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:5547 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964882AbWFSUML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:12:11 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.17: dmesg flooded with "ohci_hcd 0000:00:02.0: wakeup"
Date: Mon, 19 Jun 2006 13:12:06 -0700
User-Agent: KMail/1.7.1
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
References: <200606181919.51126.arvidjaar@mail.ru> <200606181116.20815.david-b@pacbell.net> <200606192239.06208.arvidjaar@mail.ru>
In-Reply-To: <200606192239.06208.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606191312.07063.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > An alternative (but post-boot) workaround _should_ be
> > > >
> > > >     echo disabled > /sys/bus/pci/devices/0000:00:02.0/power/wakeup
> >
> > Did that work?
> >
> 
> No. But
> 
> 	echo -n disabled > /sys/devices/pci0000:00/0000:00:02.0/usb1/power/wakeup

That's what I meant ... thanks, and sorry for the confusion.
