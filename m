Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbTDOEUx (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 00:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264161AbTDOEUx (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 00:20:53 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48903 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264138AbTDOEUw (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 00:20:52 -0400
Date: Tue, 15 Apr 2003 00:27:50 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: oops when using hdc=ide-scsi (2.5.66)
In-Reply-To: <1049740232.2965.80.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1030415002500.22538A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Apr 2003, Alan Cox wrote:

> On Llu, 2003-04-07 at 20:02, Randy.Dunlap wrote:
> > Hi,
> > 
> > I get this when I boot 2.5.66 and the Linux command line contains
> > "hdc=ide-scsi".  Yes, I know that I can remove that option (as in
> > "DDT"), but the kernel shouldn't do this, either.
> 
> ide_scsi is completely broken in 2.5.x. Known problem. If you need it
> either use 2.4 or fix it 8)

Is that an official position that it will not be supported? People with MO
drives and tape will be supported only on 2.4?

It would make more sense to treat all ATAPI devices as SCSI, I would
think, but I assume there's a good reason for this decision.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

