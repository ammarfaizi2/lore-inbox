Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269398AbUI3UG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269398AbUI3UG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269474AbUI3UGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:06:47 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:9583 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269477AbUI3UGF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:06:05 -0400
Subject: Re: Serial driver hangs
From: Paul Fulghum <paulkf@microgate.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040930205922.F5892@flint.arm.linux.org.uk>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
	 <200409291607.07493.roland.cassebohm@visionsystems.de>
	 <1096467951.1964.22.camel@deimos.microgate.com>
	 <200409301816.44649.roland.cassebohm@visionsystems.de>
	 <1096571398.1938.112.camel@deimos.microgate.com>
	 <1096569273.19487.46.camel@localhost.localdomain>
	 <1096573912.1938.136.camel@deimos.microgate.com>
	 <20040930205922.F5892@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1096574739.1938.142.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 30 Sep 2004 15:05:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 14:59, Russell King wrote:
> On Thu, Sep 30, 2004 at 02:51:52PM -0500, Paul Fulghum wrote:
> > On Thu, 2004-09-30 at 13:34, Alan Cox wrote:
> > > This is strictly forbidden and always has been. I've no
> > > plan to touch that restriction merely to re-educate 
> > > any offender
> > 
> > Any offender in this case is most serial drivers,
> > including the 8520/serial driver in current 2.6
> 
> which in turn also means the bug exists in 2.4...

Yes, it is also in serial.c of 2.4

My statement of 'most drivers' is wrong.
I should have said 'some drivers'
including 2.4 serial.c and the 8250/serial of 2.6

-- 
Paul Fulghum
paulkf@microgate.com

