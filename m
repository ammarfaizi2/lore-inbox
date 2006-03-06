Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWCFNAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWCFNAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWCFNAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:00:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:3277 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751005AbWCFNAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:00:52 -0500
Date: Mon, 6 Mar 2006 13:00:50 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Mathieu Chouquet-Stringer <mchouque@free.fr>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       Richard Henderson <rth@twiddle.net>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem on Alpha with "convert to generic irq framework"
Message-ID: <20060306130050.GI27946@ftp.linux.org.uk>
References: <20060304111219.GA10532@localhost> <20060306155114.A8425@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306155114.A8425@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 03:51:14PM +0300, Ivan Kokshaysky wrote:
> On Sat, Mar 04, 2006 at 12:12:19PM +0100, Mathieu Chouquet-Stringer wrote:
> > I can trigger the bug almost instantly and I get, more or less randomly,
> > the following panic messages (without traces):
> > 
> > Aiee, killing interrupt handler!
> > Attempted to kill the idle task!
> > Unable to handle kernel paging request at virtual address
> 
> I cannot reproduce that, but all my machines use SRM, so interrupt
> handling is quite different from AlphaBIOS systems.
> 
> > system type             : EB164
> > system variation        : LX164
> > system revision         : 0
> > system serial number    : MILO-2.2-18
> 
> I'll try to install AlphaBIOS/MILO on my lx164 to see what happens.

FWIW, works here on DS10 and alphastation (both with SRM)...
