Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbTEXPnD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 11:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTEXPnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 11:43:03 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:63751 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262090AbTEXPnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 11:43:02 -0400
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <156240000.1053787871@aslan.scsiguy.com>
References: <1053732598.1951.13.camel@mulgrave>
		<20030524064340.GA1451@alpha.home.local>
	<1053786998.1793.31.camel@mulgrave> 
	<156240000.1053787871@aslan.scsiguy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 May 2003 11:55:54 -0400
Message-Id: <1053791756.1793.55.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-24 at 10:51, Justin T. Gibbs wrote:
> Just for clarification.  Marcelo never asked me for a fix.  The only
> mail I received from him was an informational message indicating that
> the code was being backed out.  If I had been provided an opportunity
> to fix the problem, I would have. Considering that the fix has been
> available long before RC2 was cut (May 1st.), it's not hard to see that
> getting a proper fix required nothing more than just upgrading the driver
> or contacting its maintainer to get a paired down fix.

The kernel, as you have been told several times before, follows a push
model, not a pull one.  Just looking after SCSI, I don't have time to go
around asking all the driver writers for updates; likewise Marcelo
really doesn't have the time to do this for everything in the 2.4
kernel.

Every maintained piece of the kernel has a listed maintainer to whom the
bug reports are supposed to go.  The expectation is that these
maintainers will see the bug reports and pro-actively provide fixes
before they become release issues.  The maintainers also do
enhancements, *but* these enhancements should follow the proper release
cycle (i.e. in at the early -pre stage).

Could you please get with the program?  The bug fix vs enhancement issue
hasn't previously mattered that much for 2.5, but I anticipate we'll be
following a similar model when 2.6 is released.

James


