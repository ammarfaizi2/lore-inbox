Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbUCHSuG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 13:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbUCHSuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 13:50:06 -0500
Received: from palrel12.hp.com ([156.153.255.237]:62131 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261720AbUCHSuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 13:50:01 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16460.49234.541568.642296@napali.hpl.hp.com>
Date: Mon, 8 Mar 2004 10:49:54 -0800
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <404A0AB7.5020603@pacbell.net>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
	<20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
	<16289.29015.81760.774530@napali.hpl.hp.com>
	<16289.55171.278494.17172@napali.hpl.hp.com>
	<3FA28C9A.5010608@pacbell.net>
	<16457.12968.365287.561596@napali.hpl.hp.com>
	<404959A5.6040809@pacbell.net>
	<16457.38721.119739.816533@napali.hpl.hp.com>
	<404A0AB7.5020603@pacbell.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 06 Mar 2004 09:30:31 -0800, David Brownell <david-b@pacbell.net> said:

  David.B> David Mosberger wrote:

  >> Here is patch #3.  It also Works For Me.  I was wondering whether
  >> it

  David.B> I've had several "Works For Me" patches too, but then if
  David.B> the silicion got kicked a bit differently it'd not
  David.B> behave... :(

Just for completeness, I can confirm this.  Depending on the exact USB
configuration (varying number and types of devices connected via a
varying number of hubs), there are still problems.  So clearly my
patches didn't address the root cause (yet).

	--david
