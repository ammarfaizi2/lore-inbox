Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbVLEXAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbVLEXAv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbVLEXAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:00:51 -0500
Received: from mail.enyo.de ([212.9.189.167]:34525 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1751488AbVLEXAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:00:50 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<1133620264.2171.14.camel@localhost.localdomain>
	<20051203193538.GM31395@stusta.de>
	<1133639835.16836.24.camel@mindpipe>
	<20051203225815.GH25722@merlin.emma.line.org>
	<1133653782.19768.1.camel@mindpipe> <87u0dn5k6m.fsf@mid.deneb.enyo.de>
	<1133818877.21641.92.camel@mindpipe>
Date: Tue, 06 Dec 2005 00:00:41 +0100
In-Reply-To: <1133818877.21641.92.camel@mindpipe> (Lee Revell's message of
	"Mon, 05 Dec 2005 16:41:16 -0500")
Message-ID: <87mzjf409y.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell:

> On Mon, 2005-12-05 at 22:05 +0100, Florian Weimer wrote:
>> * Lee Revell:
>> 
>> >> The point that just escaped you as the motivation for this thread was
>> >> the availability of security (or other critical) fixes for older
>> >> kernels. It would all be fine if, say, the fix for CVE-2004-2492 were
>> >> available for those who find 2.6.8 works for them (the fix went into
>> >> 2.6.14 BTW), and the concern is the development model isn't fit to
>> >> accomodate needs like this.
>> >> 
>> >
>> > If you want security fixes backported then you can get a distro kernel.
>> 
>> And these distro kernels appear magically from nowhere?
>> 
>
> No you get them from Red Hat or SuSE or whoever.

"Whoever"?  Debian?  Slackware?  Gentoo?  Even companies like SGI
might have difficulties providing security support for their custom
kernels, not to speak of tons of embedded developers.

Can I buy security support for my custom MIPS kernel, like I can buy
GCC support for the platform?  Is there a similar market?

> One of the core assumptions of the new development model is that
> distros whose business model involves paying people to do QA and
> regression testing and have access to bug reports from zillions of
> users are better positioned than kernel developers to decide what a
> "stable" kernel is.

But they aren't more qualified when it comes to extracting security
fixes (and other critical bug fixes).  For picking functionality, I
agree, but critical bug fixes which basically affect everone are a
different matter.  It doesn't make sense to redo the same analysis
over and over again, at each vendor.
