Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWH3WKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWH3WKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWH3WKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:10:20 -0400
Received: from mail.suse.de ([195.135.220.2]:5305 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932160AbWH3WKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:10:19 -0400
Date: Wed, 30 Aug 2006 15:08:56 -0700
From: Greg KH <greg@kroah.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Matthias Schniedermeyer <ms@citd.de>,
       Matt Porter <mporter@embeddedalley.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060830220855.GA13554@kroah.com>
References: <20060830062338.GA10285@kroah.com> <20060830143410.GB19477@gate.crashing.org> <20060830175529.GB6258@kroah.com> <44F5FCA7.3080509@citd.de> <Pine.LNX.4.61.0608301707130.26205@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608301707130.26205@chaos.analogic.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 05:25:45PM -0400, linux-os (Dick Johnson) wrote:
> User mode drivers are NOT good. For them to work, too much stuff
> needs to be exposed. Then there is the problem of interrupts.
> You are not going to be able to make an interrupt 'thunker' like
> you could in the old DOS days. The kernel isn't going to call
> user-mode code because nobody is going to provide such a potentially
> destructive interface. If you think you can handle hardware interrupt
> requests with the poll() interface, you are going to be in a world of
> hurt for throughput.

If you feel this way, then don't use them on your system, for your
hardware.
