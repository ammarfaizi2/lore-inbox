Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266025AbUGTRJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbUGTRJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 13:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUGTRJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 13:09:23 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:63205 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266025AbUGTRJV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 13:09:21 -0400
Subject: Re: [PATCH][2.4 Backport] x445 usb legacy fix
From: john stultz <johnstul@us.ibm.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, vojtech@suse.cz
In-Reply-To: <20040719200608.280d17a1@lembas.zaitcev.lan>
References: <1090289222.1388.461.camel@cog.beaverton.ibm.com>
	 <20040719200608.280d17a1@lembas.zaitcev.lan>
Content-Type: text/plain
Message-Id: <1090344174.1388.471.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Jul 2004 10:22:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-19 at 20:06, Pete Zaitcev wrote:
> On Mon, 19 Jul 2004 19:07:03 -0700
> john stultz <johnstul@us.ibm.com> wrote:
> 
> The patch looks a little dirty in small places, e.g. the double
> semicolon, the HZ/100 instead of HZ/10, space, two variables
> named "base" in two blocks. I do not believe Vojtech wrote it.
> He must have gotten it from someone else.

The whitespace and double semicolon have been removed already. I'm not
sure I follow the HZ/100 bit (as my understanding is 1/100'th of a
second is the desired wait time). If you could clarify the error you
see, I'll fix it and resend the patch.

> But in any case, it's not something I can decide. Marcelo has that
> power for stock kernels, and for Red Hat kernels there's a process
> which starts with Bugzilla.

I was under the impression you were the 2.4 USB maintainer. Am I
misdirecting this patch? 

thanks
-john


