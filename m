Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWHRSRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWHRSRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWHRSRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:17:08 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:7344 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750709AbWHRSRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:17:06 -0400
Subject: Re: Serial issue
From: Lee Revell <rlrevell@joe-job.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <44E602C8.3030805@microgate.com>
References: <1155862076.24907.5.camel@mindpipe>
	 <1155915851.3426.4.camel@amdx2.microgate.com>
	 <1155923734.2924.16.camel@mindpipe>  <44E602C8.3030805@microgate.com>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 14:17:04 -0400
Message-Id: <1155925024.2924.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 13:11 -0500, Paul Fulghum wrote:
> Lee Revell wrote:
> > But it had no effect.
> > 
> > Could it be a hardware-specific bug?  After all VIA chipsets are
> > notorious for interrupts not working right.
> > 
> > Any other suggestions?
> 
> I can't think of any. The interrupts are occurring
> and being serviced. Nothing else seems to be sitting
> on that interrupt. It's reaching a bit: maybe there
> is some console output interfering with the
> file transfer protocol, but it only occurs with
> interrupt enabled because of some initial timing?
> (polling mode may delay things enough to work)
> What protocol is ckermit using? (zmodem, etc)
> 

I think it's just using the kermit file transfer protocol.

Lee

