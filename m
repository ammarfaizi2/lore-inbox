Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbTDOHFk (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 03:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbTDOHFk (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 03:05:40 -0400
Received: from mail.ithnet.com ([217.64.64.8]:55814 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264375AbTDOHFj (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 03:05:39 -0400
Date: Tue, 15 Apr 2003 09:03:57 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: alan@lxorguk.ukuu.org.uk, rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: oops when using hdc=ide-scsi (2.5.66)
Message-Id: <20030415090357.5d5586b4.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.3.96.1030415002500.22538A-100000@gatekeeper.tmr.com>
References: <1049740232.2965.80.camel@dhcp22.swansea.linux.org.uk>
	<Pine.LNX.3.96.1030415002500.22538A-100000@gatekeeper.tmr.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003 00:27:50 -0400 (EDT)
Bill Davidsen <davidsen@tmr.com> wrote:

> On 7 Apr 2003, Alan Cox wrote:
> 
> > On Llu, 2003-04-07 at 20:02, Randy.Dunlap wrote:
> > > Hi,
> > > 
> > > I get this when I boot 2.5.66 and the Linux command line contains
> > > "hdc=ide-scsi".  Yes, I know that I can remove that option (as in
> > > "DDT"), but the kernel shouldn't do this, either.
> > 
> > ide_scsi is completely broken in 2.5.x. Known problem. If you need it
> > either use 2.4 or fix it 8)
> 
> Is that an official position that it will not be supported? People with MO
> drives and tape will be supported only on 2.4?

Don't forget the merely not existing SCSI CD/DVD writers, just about all of
them are ATAPI. I guess a non-working ide-scsi module won't work out for any of
the distros...

-- 
Regards,
Stephan
