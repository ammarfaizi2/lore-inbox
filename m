Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269710AbUJAH77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269710AbUJAH77 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 03:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269702AbUJAH77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 03:59:59 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:45725 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269717AbUJAH75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 03:59:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.6.9-rc3: USB OHCI failure on suspend on AMD64
Date: Fri, 1 Oct 2004 10:02:20 +0200
User-Agent: KMail/1.6.2
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, Pavel Machek <pavel@suse.cz>
References: <200409302251.30903.rjw@sisk.pl> <200409301458.01099.david-b@pacbell.net>
In-Reply-To: <200409301458.01099.david-b@pacbell.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410011002.20517.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 of September 2004 23:58, David Brownell wrote:
> On Thursday 30 September 2004 1:51 pm, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > It seems there's a problem with USB OHCI driver that causes these traces 
to 
> > appear on suspend on an AMD64-based box:
> 
> Not all parts of power management integrate well yet with each other,
> though it's acting better.  Plus there are some OHCI updates in the USB
> patches (you'll have those in the MM tree) that help address some of
> the more perverse ways that suspend-to-disk kicks USB around, and
> a few similar usbcore changes that need re-integration with the RC3
> swsusp/pmdisk updates.
> 
> Keep using the "rmmod" workaround for now.  And don't combine
> CONFIG_USB_SUSPEND with suspend-to-{disk,ram} unless you're
> feeling like debugging the results.

I'm doing just this.  And reporting. ;-)

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
