Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWCFMvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWCFMvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 07:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWCFMvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 07:51:20 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:40142 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1751191AbWCFMvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 07:51:19 -0500
Date: Mon, 6 Mar 2006 15:51:14 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Mathieu Chouquet-Stringer <mchouque@free.fr>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       Richard Henderson <rth@twiddle.net>, Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem on Alpha with "convert to generic irq framework"
Message-ID: <20060306155114.A8425@jurassic.park.msu.ru>
References: <20060304111219.GA10532@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060304111219.GA10532@localhost>; from mchouque@free.fr on Sat, Mar 04, 2006 at 12:12:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 12:12:19PM +0100, Mathieu Chouquet-Stringer wrote:
> I can trigger the bug almost instantly and I get, more or less randomly,
> the following panic messages (without traces):
> 
> Aiee, killing interrupt handler!
> Attempted to kill the idle task!
> Unable to handle kernel paging request at virtual address

I cannot reproduce that, but all my machines use SRM, so interrupt
handling is quite different from AlphaBIOS systems.

> system type             : EB164
> system variation        : LX164
> system revision         : 0
> system serial number    : MILO-2.2-18

I'll try to install AlphaBIOS/MILO on my lx164 to see what happens.

Ivan.
