Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVEBPbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVEBPbo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 11:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVEBPbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 11:31:44 -0400
Received: from mail0.lsil.com ([147.145.40.20]:39599 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261336AbVEBPbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 11:31:31 -0400
Message-ID: <91888D455306F94EBD4D168954A9457C022CFF4E@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: RE: 2.6 upgrade overall failure report
Date: Mon, 2 May 2005 09:31:03 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 29, 2005 3:57 AM, Hubert Tonneau wrote:
> Andrew Morton wrote:
> >
> > >  . I reported a year ago that SCSI fusion was unable to 
> properly recover from
> > >    tiny errors under 2.6 as opposed to 2.4 ... and got 
> hit by the same problem
> > >    6 monthes later
> > 
> > Please send a full report to Eric Moore and cc 
> linux-scsi@vger.kernel.org
> 
> Already done.
> My initial report to Eric Moore is dated mai 15 2004 (2.6.6), 
> so you can
> understand why I'm a bit afraid beeing hit by the same bug 
> more than 6 monthes
> and 3 stable kernel releases later.
> After the second report dated january 26 2005 (2.6.9),
> he sent me fusion 3.1.19 saying it solves the problem.
> As far as I could check, no official kernel is running 3.1.19
> 2.6.12 will jump to 3.1.20, so I can assume it's solved;
> also I have no way to verify it since the bug will append 
> only in case of
> something going wrong on the SCSI chain, what tends to append only
> once every several monthes, and not on all servers.


There have been improvements made in the error handling area in
the mpt fusion driver.  Basically the timers were removed.
This was done in the 3.01.19 driver, which was posted around
early February, 2005.  That support is still there in all drivers 
versions posted since then.

Eric


 
