Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSKRMtV>; Mon, 18 Nov 2002 07:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSKRMtV>; Mon, 18 Nov 2002 07:49:21 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:31411 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262420AbSKRMs0>; Mon, 18 Nov 2002 07:48:26 -0500
Subject: Re: Status of the CMD680 IDE driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vitezslav Samel <samel@mail.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021118102653.GB425@pc11.op.pod.cz>
References: <73fe.3dd52324.188a7@gzp1.gzp.hu>
	<1037383237.19971.49.camel@irongate.swansea.linux.org.uk> 
	<20021118102653.GB425@pc11.op.pod.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Nov 2002 13:23:02 +0000
Message-Id: <1037625782.7547.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-18 at 10:26, Vitezslav Samel wrote:
> On Fri, Nov 15, 2002 at 06:00:37PM +0000, Alan Cox wrote:
> > On Fri, 2002-11-15 at 16:39, Gabor Z. Papp wrote:
> > > Seems like it is in the later 2.4, but removed from the -ac
> > > line, and missing from the 2.5 tree.
> > 
> > siimage driver drives the CMD680 and the SATA SII3112 version of the
> > chip.
> 
>   I tried it, but performance drops from 44 MB/s to cca. 20 MB/s 
> when using new seagate drive in udma5 between 2.4 and 2.5 version.

Feel free to debug it. Start by checking that its detecting 40/80pin
cables correctly given that paticular report


Alan
