Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUBLTyT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 14:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUBLTyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 14:54:19 -0500
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:42758 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S266566AbUBLTyR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 14:54:17 -0500
Date: Thu, 12 Feb 2004 13:54:17 -0600 (CST)
From: Derek Foreman <manmower@signalmarketing.com>
To: Daniel Drake <dan@reactivated.net>
cc: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org,
       Jamie Lokier <jamie@shareable.org>, Ian Kumlien <pomac@vapor.com>,
       Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
 instead of apic ack delay.
In-Reply-To: <402BA5BD.9070307@reactivated.net>
Message-ID: <Pine.LNX.4.58.0402121324410.862@gonopodium.signalmarketing.com>
References: <200402120122.06362.ross@datscreative.com.au>
 <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com>
 <402BA5BD.9070307@reactivated.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Daniel Drake wrote:

> Derek Foreman wrote:
> > Is there a measurable performance loss over not having the patch at all?
> > Some nforce2 systems work just fine.  Is there a way to distinguish
> > between systems that need it and those that don't?
>
> Do you have one of those systems to hand? My betting is on that when you
> enable APIC/IOAPIC you will see crashes very frequently. This isn't enabled in
> the default kernel config..

APIC, ACPI, IOAPIC, enabled or disabled..  lots of different kernels
soltek frn2 nforce2 based board, barton XP 2500+, 512mb ddr
Bios doesn't allow disabling of stop grant, but I've tried both states
with athcool.

It's really entering the stop grant state, because when completely idle it
makes a measurable heat difference.  (though when playing mp3s, almost all
of the cooling benefit is lost)

This machine hasn't crashed yet.

If there's something I can do to crash it so I don't feel special
anymore,  or if there's some way I can provide useful information, let me
know.

> PS, Ross: Again, great work, thanks. I am running the patches you posted in
> the thread starter (without the previous ones) on 2.6.3-rc2-mm1 without problem.

I hope my email wasn't interpreted as an attack on the patch.  I think
getting linux running on flakey hardware without any support at all from
the manufacturer is incredibly cool.
