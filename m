Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270413AbTGVKJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 06:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270487AbTGVKJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 06:09:32 -0400
Received: from shackc.compushack.de ([195.145.90.67]:57095 "EHLO
	shackc.compu-shack.com") by vger.kernel.org with ESMTP
	id S270413AbTGVKJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 06:09:30 -0400
Subject: Re: CPU Lockup with 2.4.21 and 2.4.22-pre
From: Michael =?ISO-8859-1?Q?Tro=DF?= <mtross@compu-shack.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <0001F3D0@gwia.compu-shack.com>
References: <0001F3D0@gwia.compu-shack.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Compu-Shack Production
Message-Id: <1058869462.2352.79.camel@mtross2.csintern.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 22 Jul 2003 12:24:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 2003-07-21 um 16.17 schrieb Udo A. Steinberg:
> On Mon, 21 Jul 2003 16:12:26 +0200 Udo A. Steinberg (UAS) wrote:
> 
> UAS> We have a Dual-Xeon machine with Hyperthreading which keeps locking
> up hard,
> UAS> so that not even Sysrq works anymore. I have captured such a lockup
> using the
> UAS> NMI oopser. Below you'll find the lockup fed through ksymoops. Note
> that
> UAS> after CPU3 locked up, CPU2 did too. But that lockup couldn't be
> captured
> UAS> anymore. Kernel is a monolithic 2.4.22-pre6. Problem also happened
> on
> UAS> plain 2.4.21. I can provide more information wrt. hardware, config
> etc.
> UAS> on request.

Would be really useful if you do so.

> Sorry, I used the wrong System.map. Below is the fixed decode. Looks
> like
> the lockup is caused by the 3rd party Compushack FDDI driver.

What makes you believe this? There is no matching code sequence like the
one from your dump in the driver, to be exact: in a driver compiled with
gcc 3.3 and kernel 2.4.21.

> Regards,
> -Udo.

Regards,
Michael

