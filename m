Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319069AbSHMUq1>; Tue, 13 Aug 2002 16:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319070AbSHMUq0>; Tue, 13 Aug 2002 16:46:26 -0400
Received: from outbound.ea.com ([159.153.6.6]:15314 "EHLO outbound.ea.com")
	by vger.kernel.org with ESMTP id <S319069AbSHMUqZ>;
	Tue, 13 Aug 2002 16:46:25 -0400
Subject: Re: searching for dell 2650 PERC3-DI driver
From: Thomas Schenk <tschenk@origin.ea.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1029241024.22847.24.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0208131503350.1075-100000@boston.corp.fedex.com>
	 <1029241024.22847.24.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Aug 2002 15:45:10 -0500
Message-Id: <1029271515.7215.3.camel@tschenk5.home.techdog.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 07:17, Alan Cox wrote:
> On Tue, 2002-08-13 at 08:04, Jeff Chua wrote:
> > I'm buying a Dell PowerEdge 2650 and need to know where to get driver for
> > the RAID controller
> > 
> >         PERC3-DI, PERC3-DC, or PERC3-QC
> > 
> > Does anyone know what kind of network adaptor is on the board?
> 
> It'll either be a megaraid or aacraid. 
> 
> Alan

The Di and Si are aacraid.  Most of the others are megaraid.  As for the
NICs, they are probably the BCM5700 Gigabit ethernet, which can use the
bcm5700 module or the tg3 module.

Tom S.

