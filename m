Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275683AbTHOEwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 00:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275684AbTHOEwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 00:52:51 -0400
Received: from storm.he.net ([64.71.150.66]:10665 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S275683AbTHOEws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 00:52:48 -0400
Date: Thu, 14 Aug 2003 21:52:38 -0700
From: Greg KH <greg@kroah.com>
To: Ian Molton <spyro@f2s.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [BUG] ipaq USBserial driver
Message-ID: <20030815045238.GB29502@kroah.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, Ian Molton <spyro@f2s.com>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20030815021401.792fae10.spyro@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815021401.792fae10.spyro@f2s.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-xfs (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 02:14:01AM +0100, Ian Molton wrote:
> Hi.
> 
> Havent had time to track this down but the ipaq.c driver seems to have a
> problem since about 2.5.57 or so.
> 
> I get repeatable stiffing of 2.6.0-test3 if I place my toshiba e750 in
> the cradle while ipaq.ko is loaded. if it isnt loaded the machine is
> fine. Im using uhci-hcd.

Can you try using the nmi watchdog to see where the kernel is locked up at?

> the e750 needs ipaq.c too be modified btw. (its prod id is 0x0409 not
> 0406 as is the toshiba e740).

Try sending a patch to the author/maintainer of this driver.

thanks,

greg k-h
