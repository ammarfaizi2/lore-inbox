Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbUBWTqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 14:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbUBWTqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 14:46:20 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:18608 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S262013AbUBWTqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 14:46:19 -0500
X-qfilter-stat: ok
X-Analyze: Velop Mail Shield v0.0.4
Date: Mon, 23 Feb 2004 16:46:16 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: Nick Warne <nick@ukfsn.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: (Fwd) Re: 2.6.3 RT8139too NIC problems [resolved]
In-Reply-To: <403A4B8B.14358.FE1FB73@localhost>
Message-ID: <Pine.LNX.4.58.0402231640400.30744@pervalidus.dyndns.org>
References: <403A4B8B.14358.FE1FB73@localhost>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004, Nick Warne wrote:

> "This is usually irq routing related...  Try booting with 'noapic' or
> similar. Jeff"
>
> OK, this was the solution.  I am right bloody idiot.  Good call Jeff.
>
> Sorry to bother you guys when nothing is wrong, and I apologise for
> me being a dipstick twice over :/

Sure something is. APIC is broken for you, right ? As it's for
me - see
http://marc.theaimsgroup.com/?l=linux-kernel&m=107721911802649&w=2

Yes, it'd be nice to get it working without ACPI, but it's an
improvement that ACPI now works (also in 2.4.25).

But you wrote "This happens about once every 3 hours.", so it
doesn't seem to be completely broken as it's for me.

-- 
http://www.pervalidus.net/contact.html
