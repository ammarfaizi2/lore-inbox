Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbTFAUcF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 16:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264727AbTFAUcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 16:32:05 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:51462 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264726AbTFAUcE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 16:32:04 -0400
Date: Sun, 1 Jun 2003 22:45:16 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       Daniel Podlejski <underley@underley.eu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx problem
Message-ID: <20030601204516.GA15693@alpha.home.local>
References: <20030531165945.GA5561@witch.underley.eu.org> <20030601083656.GI21673@alpha.home.local> <2859720000.1054499680@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2859720000.1054499680@aslan.scsiguy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 02:34:40PM -0600, Justin T. Gibbs wrote:
> > Hmmm that makes quite a difference ! I didn't understand what happened between
> > these two outputs. Also, did you try with Justin's latest version of the driver:
> > 
> 
> My driver can't fix interrupt routing issues which is what Daniel's
> problem turned out to be.  I'm really tempted to add an interrupt
> test to the driver attach so that these kinds of problems are clearly
> flagged and my driver doesn't continue to get blamed for interrupt
> routing it can't control.

If this is (relatively) easy to do, I really think it could be a valuable
diagnostic tool. I'd prefer to get a clear "fix your APIC" or any insult
about my hardware config than devices detection dying in endless timeout
loops.

This principle may even be generalized to any other driver which can make the
device trigger an interrupt.

Cheers,
Willy

