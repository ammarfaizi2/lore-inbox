Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTEFORh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263808AbTEFORh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:17:37 -0400
Received: from mail.ithnet.com ([217.64.64.8]:40719 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263807AbTEFORO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:17:14 -0400
Date: Tue, 6 May 2003 16:01:53 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kkeil@suse.de, kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
Subject: Re: ISDN massive packet drops while DVD burn/verify
Message-Id: <20030506160153.44ea4eee.skraw@ithnet.com>
In-Reply-To: <1052225795.1201.11.camel@dhcp22.swansea.linux.org.uk>
References: <20030416151221.71d099ba.skraw@ithnet.com>
	<Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu>
	<20030419193848.0811bd90.skraw@ithnet.com>
	<1050789691.3955.17.camel@dhcp22.swansea.linux.org.uk>
	<20030505164653.GA30015@pingi3.kke.suse.de>
	<20030505192652.7f17ea9e.skraw@ithnet.com>
	<1052218412.28797.18.camel@dhcp22.swansea.linux.org.uk>
	<20030506143902.2b3fcecd.skraw@ithnet.com>
	<1052225795.1201.11.camel@dhcp22.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 May 2003 13:56:37 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2003-05-06 at 13:39, Stephan von Krawczynski wrote:
> >  HDIO_GET_MULTCOUNT failed: Invalid argument
> >  IO_support   =  0 (default 16-bit)
> >  unmaskirq    =  0 (off)
> >  using_dma    =  1 (on)
> >  keepsettings =  0 (off)
> >  readonly     =  0 (off)
> >  BLKRAGET failed: Invalid argument
> >  HDIO_GETGEO failed: Invalid argument
> >  
> > 
> > using_dma means it's using dma for transfer, right?
> 
> Except for certain operations like audio cd ripping

Not used here.
We are using the DVDs (DVD-R) for data backups, some dozens a month.
And keep in mind: the problem occurs currently only while writing to DVD, not
while reading it.

Regards,
Stephan
