Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289422AbSA1UaG>; Mon, 28 Jan 2002 15:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289369AbSA1U2L>; Mon, 28 Jan 2002 15:28:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56330 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289388AbSA1U1I>;
	Mon, 28 Jan 2002 15:27:08 -0500
Message-ID: <3C55B27D.AF95BFF7@zip.com.au>
Date: Mon, 28 Jan 2002 12:20:13 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kevin Breit <mrproper@ximian.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ethernet data corruption?
In-Reply-To: <3C55AE06.9C9AB33F@zip.com.au>,
		<1012250404.5401.6.camel@kbreit.lan> 
		<3C55AE06.9C9AB33F@zip.com.au> <1012252669.6159.16.camel@kbreit.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Breit wrote:
> 
> On Mon, 2002-01-28 at 14:01, Andrew Morton wrote:
> > However, a number of ethernet cards do IP checksumming in
> > hardware, so the kernel doesn't bother doing the checksum
> > in software.
> Interesting
> 
> > What ethernet card are you using?
> I am using a built in (I think it's on the mobo actually) Intel
> EtherExpress 10/100 Pro:
> 
> eepro100               17680   1
> 

Oh well, there goes that theory.  eepro100.c does software
checksumming.

-
