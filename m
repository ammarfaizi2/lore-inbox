Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270862AbTGVPLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 11:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270864AbTGVPLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 11:11:09 -0400
Received: from shackc.compushack.de ([195.145.90.67]:1285 "EHLO
	shackc.compu-shack.com") by vger.kernel.org with ESMTP
	id S270862AbTGVPLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 11:11:08 -0400
Subject: Re: CPU Lockup with 2.4.21 and 2.4.22-pre
From: Michael =?ISO-8859-1?Q?Tro=DF?= <mtross@compu-shack.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <0001F49C@gwia.compu-shack.com>
References: <0001F49C@gwia.compu-shack.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Compu-Shack Production
Message-Id: <1058887570.2357.157.camel@mtross2.csintern.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 22 Jul 2003 17:26:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Die, 2003-07-22 um 16.24 schrieb Udo A. Steinberg:

> MT> As you might know, the Compu-Shack fddi products reached end-of-life
> MT> last year.
> 
> Yes. Just thought I'd let you know that we aren't using the same
> patch as on the website, but one that has been rediffed for 2.4.21 and
> has an additional fix from you in it.

Mentioned it just to let you know that the company is no longer
providing new drivers for new kernels. Probably you better stay with
2.4.18.

[snip]

Seems that a spin lock is already held. Do you get this oops right after
opening the device? Then please try NoSelfTest.

Regards,
Michael

