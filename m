Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTIZPdE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 11:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTIZPdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 11:33:04 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:6667 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262362AbTIZPdC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 11:33:02 -0400
From: Michael Frank <mhf@linuxmail.org>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=)
Subject: Re: [BUG?] SIS IDE DMA errors
Date: Fri, 26 Sep 2003 23:32:30 +0800
User-Agent: KMail/1.5.2
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <200309262208.30582.mhf@linuxmail.org> <yw1x3cejlk34.fsf@users.sourceforge.net>
In-Reply-To: <yw1x3cejlk34.fsf@users.sourceforge.net>
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309262332.30091.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 September 2003 22:07, Måns Rullgård wrote:
> Michael Frank <mhf@linuxmail.org> writes:
> 
> > Suspect chipset related issue which should be looked into.
> 
> That's what someone told me three months ago, too.  Nothing happened,
> though.
> 

OK, now that we are two, we copy the IDE maintainer ;)

I guess it is fair to say that we are happy to test patches.

And here is my lspci -vv.

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5332
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin ? routed to IRQ 10
        Region 4: I/O ports at 4000 [size=16]
        Capabilities: <available only to root>


Regards
Michael

