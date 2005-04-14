Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVDNVEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVDNVEC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 17:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVDNVEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 17:04:02 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:919 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261590AbVDNVD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 17:03:59 -0400
Subject: Re: spurious 8259A interrupt: IRQ7
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1113512210.19373.3.camel@mindpipe>
References: <1113498693.18871.11.camel@mindpipe>
	 <1113511426.22496.43.camel@eeyore>  <1113512210.19373.3.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 15:03:58 -0600
Message-Id: <1113512638.22496.47.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-14 at 16:56 -0400, Lee Revell wrote:
> Is the VIA IRQ fixup related to the "spurious interrupts" messages in
> any way?  Googling the 2.4 threads on the issue gave me the impression
> that it's related to broken hardware.  I think excessive disk activity
> might trigger it.

If you need the VIA IRQ fixup and don't have it, I would expect
some interrupt to be routed to the wrong IRQ.  That might give
you a "spurious interrupt" on the wrong IRQ, but your device would
probably just not work at all.


