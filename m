Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265418AbUFOLdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbUFOLdX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 07:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbUFOLdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 07:33:23 -0400
Received: from smtp.telefonica.net ([213.4.129.135]:17262 "EHLO
	tnetsmtp1.mail.isp") by vger.kernel.org with ESMTP id S265418AbUFOLdW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 07:33:22 -0400
Subject: Re: pdc202xx_old serious bug with DMA on 2.6.x series
From: Adolfo =?ISO-8859-1?Q?Gonz=E1lez_Bl=E1zquez?= 
	<agblazquez_mailing@telefonica.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040615111552.GA12458@logos.cnet>
References: <1087253451.4817.4.camel@localhost>
	 <200406150118.34034.bzolnier@elka.pw.edu.pl>
	 <1087255203.4814.10.camel@localhost>  <20040615111552.GA12458@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1087299182.3251.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 15 Jun 2004 13:33:03 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El mar, 15-06-2004 a las 13:15, Marcelo Tosatti escribió:
> On Tue, Jun 15, 2004 at 01:20:03AM +0200, Adolfo González Blázquez wrote:
> > El mar, 15-06-2004 a las 01:18, Bartlomiej Zolnierkiewicz escribió:
> > > On Tuesday 15 of June 2004 00:50, Adolfo González Blázquez wrote:
> > > > Hi!
> > > 
> > > Hi,
> > > 
> > > > Lot of users are reporting seriour problems with pdc202xx_old ide pci
> > > > driver. Enabling DMA on any device related with this driver makes the
> > > > system unusable.
> > > >
> > > > This seems to happen in all the 2.6.x kernel series.
> > > 
> > > Doing binary search on 2.4->2.6 kernels would help greatly
> > > (narrowing problem to a specific kernel versions).
> > 
> > If it helps, I tried 2.6.2, 2.6.4, 2.6.5, and 2.6.7-rc3, and all have
> > the bug.
> 
> And which kernels does not exhibit the problem?

The 2.4 series it's ok, I'm gonna try with different 2.5.x kernels to
see if i can discover when the bug was introduced

