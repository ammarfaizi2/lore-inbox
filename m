Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264910AbUGIOte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbUGIOte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 10:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUGIOte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 10:49:34 -0400
Received: from khepri.openbios.org ([80.190.231.112]:28292 "EHLO
	khepri.openbios.org") by vger.kernel.org with ESMTP id S264910AbUGIOtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 10:49:32 -0400
Date: Fri, 9 Jul 2004 16:48:59 +0200
From: Stefan Reinauer <stepan@openbios.org>
To: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@suse.cz>,
       Erik Rigtorp <erik@rigtorp.com>, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
Subject: Re: [PATCH] swsusp bootsplash support
Message-ID: <20040709144859.GA18243@openbios.org>
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org> <20040708204840.GB607@openzaurus.ucw.cz> <20040708210403.GA18049@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708210403.GA18049@infradead.org>
X-Operating-System: Linux 2.6.5-12.7-smp on an x86_64
User-Agent: Mutt/1.5.5.1i
X-Duff: Orig. Duff, Duff Lite, Duff Dry, Duff Dark,
	Raspberry Duff, Lady Duff, Red Duff, Tartar Control Duff, ( =?ISO-8859-1?Q?D=FCff?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig <hch@infradead.org> [040708 23:04]:
> No.  This stuff has no business in the kernel, paint your fancy graphics
> ontop of fbdev.  And the SuSE bootsplash patch is utter crap, I mean what
> do you have to smoke to put a jpeg decoder into the kernel?

Christoph, don't assume drugs just because you lack a little fantasy ;) 

I agee with kernel 2.6 one could do a lot better due to proper initramfs
handling, but in kernel 2.4 there was no decent way of placing userspace
code early enough to be executed before framebuffer initialization. 

On the other hand, the jpeg decoder is 8k object size - less than the
dozens of gzip/gunzip algorithms in the kernel, so complaining sounds a
little foolish to me. If you just want to bitch, go and critizise that
with 1024x768 the bootsplash patch eats 1.5MB of memory permanently.
THAT would make sense, if anything.

Whether one wants retro text messages or a graphical bootup mechanism is
sure a philosophical thing. IMHO starting X that early is not an option.


Stefan





