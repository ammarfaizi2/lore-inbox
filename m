Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWAQTFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWAQTFg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWAQTFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:05:36 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:59052 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S932409AbWAQTFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:05:35 -0500
Date: Tue, 17 Jan 2006 20:04:45 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Ian Campbell <icampbell@arcom.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [WATCHDOG] sa1100_wdt.c sparse cleanups
Message-ID: <20060117190445.GA4298@infomag.infomag.iguana.be>
References: <1130921809.12578.179.camel@icampbell-debian> <20051105101026.GA28438@flint.arm.linux.org.uk> <1131358884.14696.57.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131358884.14696.57.camel@icampbell-debian>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

> On Sat, 2005-11-05 at 10:10 +0000, Russell King wrote:
> 
> > It's probably better to use a union with these, eg:
> 
> The common idiom in the watchdog drivers seems to be to use separate
> variables. I'll leave it up to Wim if he wants to change that.
> 
> The following makes drivers/char/watchdog/sa1100_wdt.c sparse clean.
> 
> Signed-off-by: Ian Campbell <icampbell@arcom.com>

I seem to have missed this last e-mail (I was moving around that time...).
This is indeed how it's been done in other drivers. I just uploaded this "patch"
into my -mm test tree. Within a week or two I'll move it to the final watchdog tree.

We should look to the struct watchdog part in more detail though.
a union is an option, but probably not the only one :-)

Greetings,
Wim.

