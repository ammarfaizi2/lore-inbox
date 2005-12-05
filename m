Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVLEOsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVLEOsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVLEOsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:48:17 -0500
Received: from mail.enyo.de ([212.9.189.167]:39312 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S932431AbVLEOsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:48:17 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Greg KH <greg@kroah.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	<20051203201945.GA4182@kroah.com>
Date: Mon, 05 Dec 2005 15:48:06 +0100
In-Reply-To: <20051203201945.GA4182@kroah.com> (Greg KH's message of "Sat, 3
	Dec 2005 12:19:45 -0800")
Message-ID: <873bl7eh21.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH:

> On Sat, Dec 03, 2005 at 03:29:54PM +0100, Jesper Juhl wrote:
>> 
>> Why can't this be done by distributors/vendors?
>
> It already is done by these people, look at the "enterprise" Linux
> distributions and their 5 years of maintance (or whatever the number
> is.)
>
> If people/customers want stability, they already have this option.

It seems that vendor kernels lack most DoS-related fixes.  I'm only
aware of a single vendor which tracks them to the point that CVE names
are assigned.

Vendor kernels are not a panacea, either.  With some of the basic
support contracts (in the four-figure range per year and CPU), the
vendor won't look extensively at random kernel crashes which could (in
theory) be attributed to faulty hardware, *and* you don't get
community support for these heavily patched kernel collages.
