Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTEGB6b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 21:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTEGB6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 21:58:31 -0400
Received: from palrel13.hp.com ([156.153.255.238]:25028 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262737AbTEGB6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 21:58:30 -0400
Date: Tue, 6 May 2003 19:10:53 -0700
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wireless drivers in 2.5.69
Message-ID: <20030507021053.GA13661@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030506041929.GA5564@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506041929.GA5564@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 09:19:29PM -0700, Greg KH wrote:
> Hi,
> 
> You mentioned in your changes to the wireless core for 2.5.68 that you
> had sent updates for the various drivers to the different driver
> maintainers.  As it looks like your changes made it into 2.5.69, but the
> driver updates didn't, do you have a pointer to these updates so that
> those of us with now non-working wireless cards can test them out?
> 
> Specifically, in my case I'm looking for the updates for the orinoco_pci
> driver, as that has stopped working in 2.5.69, but was working just fine
> in 2.5.68.
> 
> thanks,
> 
> greg k-h

	I don't mind taking the blame when it's my fault, but this is
one case where you will need to find another culprit ;-)
	1) My changes were fully backward compatible and tested with
old/unmodified drivers.
	2) My changes are not included in 2.5.69 (Jeff will confirm
that).
	Without a more detailed bug report, it's difficult to
pin-point the blame, and I didn't personally had time to test
2.5.69. Arnaldo made some trivial changes to wireless.c, but I don't
believe that's broken. There is of course the irq handler stuff...

	Good luck, and keep me posted ;-)

	Jean
