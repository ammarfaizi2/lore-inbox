Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTJaSen (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 13:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbTJaSen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 13:34:43 -0500
Received: from palrel12.hp.com ([156.153.255.237]:31415 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263510AbTJaSel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 13:34:41 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16290.43822.444275.360988@napali.hpl.hp.com>
Date: Fri, 31 Oct 2003 10:34:22 -0800
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <3FA28C9A.5010608@pacbell.net>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
	<20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
	<16289.29015.81760.774530@napali.hpl.hp.com>
	<16289.55171.278494.17172@napali.hpl.hp.com>
	<3FA28C9A.5010608@pacbell.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 31 Oct 2003 08:23:54 -0800, David Brownell <david-b@pacbell.net> said:

  David.B> David Mosberger wrote:
  >> After spending a bit more time on this, it looks to me like the
  >> keyboard is crashing the system very early on.

  David.B> I think there are some devices that choke the HID
  David.B> code;

And nobody is alarmed by this?  Surely crashing the kernel by plugging
in a USB device must be considered a MUST-FIX item.  Perhaps I missed
something, but I never saw this mentioned before.

  David.B> I recall someone reporting a mouse that did the same kind of
  David.B> thing.  Do other kinds of keyboards do the same thing, or is
  David.B> it just that one?

Ugh, I only have about half a dozen or so different types of USB
devices (and even fewer of them are HID devices), so my experience
isn't exactly a statistically valid sample.  Having said that, out of
that 6 or so devices, that particular keyboard is the only one causing
crashes.  However, note that it works (mostly) fine under 2.4 and even
if they keyboard were total crap, it certainly shouldn't crash the
kernel.

	--david
