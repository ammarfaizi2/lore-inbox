Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314694AbSEPVHY>; Thu, 16 May 2002 17:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314709AbSEPVHX>; Thu, 16 May 2002 17:07:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8464 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314694AbSEPVHW>;
	Thu, 16 May 2002 17:07:22 -0400
Message-ID: <3CE41F42.ED20D0C6@zip.com.au>
Date: Thu, 16 May 2002 14:06:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Faure <paul@engsoc.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
In-Reply-To: <3CE414BF.15A0C74B@zip.com.au> <Pine.LNX.4.33.0205161650170.18851-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Faure wrote:
> 
> On Thu, 16 May 2002, Andrew Morton wrote:
> 
> > Paul Faure wrote:
> > >
> > > Just installed RedHat 7.3 with kernel 2.4.18 and noticed that my network
> > > no longer functions when my CPU usage is at 100%.
> >
> > ugh.  Which NIC are you using?
> 
> ne.o
> Its an ISA card.
> 

It's possible that this particular driver is flunking on a lot
of transmit attempts and is relying on ksoftirqd to transmit.

Are you able to test with a moderately respectable NIC?
tulip, 3com, realtek, eepro?

-
