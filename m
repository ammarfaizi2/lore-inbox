Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWCaSXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWCaSXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWCaSXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:23:13 -0500
Received: from smtp-4.llnl.gov ([128.115.41.84]:3260 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S932200AbWCaSXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:23:12 -0500
From: Dave Peterson <dsp@llnl.gov>
To: gtm.kramer@inter.nl.net, linux-kernel@vger.kernel.org
Subject: Re: Non-Fatal Error PCI Express messages
Date: Fri, 31 Mar 2006 10:22:56 -0800
User-Agent: KMail/1.5.3
References: <1143793550.3331.4.camel@paragon.slim>
In-Reply-To: <1143793550.3331.4.camel@paragon.slim>
Cc: bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603311022.56896.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 00:25, Jurgen Kramer wrote:
> With 2.6.16 (from FC5s 2.6.16-1.2080_FC5smp) I am getting a lot of
>
> Mar 31 09:35:16 paragon kernel: Non-Fatal Error PCI Express B
> Mar 31 09:35:17 paragon kernel: Non-Fatal Error PCI Express B
> Mar 31 09:35:17 paragon kernel: Non-Fatal Error PCI Express B
> Mar 31 09:35:18 paragon kernel: Non-Fatal Error PCI Express B
> Mar 31 09:35:18 paragon kernel: Non-Fatal Error PCI Express B
> Mar 31 09:35:20 paragon kernel: Non-Fatal Error PCI Express B
> Mar 31 09:35:20 paragon kernel: Non-Fatal Error PCI Express B
> Mar 31 09:35:39 paragon kernel: Non-Fatal Error PCI Express B
>
> messages which presumably come from
>
> Mar 31 09:17:15 paragon kernel: MC: drivers/edac/edac_mc.c version
> edac_mc  Ver: 2.0.0 Mar 28 2006
> Mar 31 09:17:15 paragon kernel: EDAC MC0: Giving out device to
> "e752x_edac" E7525: PCI 0000:00:00.0
>
> Is there really something broken here of just a noisy driver?
>
> BTW this is on a Asus NCT-D mobo with Intel E7525 chipset.
>
> Jurgen

Hi Jurgen,

I haven't seen this particular error before, and I can't say for sure
whether it's a genuine problem that should be dealt with or just a
minor annoyance that can be safely ignored.  EDAC is a relatively new
piece of code, and still very much a work in progress.  If this is in
fact a benign type of error, EDAC should provide a mechanism by which
a sysadmin can silence it.  This is an area of future work.

I'm forwarding your message to the bluesmoke mailing list just in
case anyone who reads that list has seen instances of this error in
the past and can provide more info on it.

Dave
