Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSCTFYJ>; Wed, 20 Mar 2002 00:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311565AbSCTFYA>; Wed, 20 Mar 2002 00:24:00 -0500
Received: from cs24344-28.austin.rr.com ([24.243.44.28]:30472 "EHLO
	explorer.dummynet") by vger.kernel.org with ESMTP
	id <S311564AbSCTFXl>; Wed, 20 Mar 2002 00:23:41 -0500
Date: Tue, 19 Mar 2002 23:23:36 -0600
From: Dan Hopper <ku4nf@austin.rr.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Promise 20265 IDE chip gets detected in wrong order 2.4.x
Message-ID: <20020320052336.GA2220@yoda.dummynet>
Mail-Followup-To: Dan Hopper <ku4nf@austin.rr.com>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020320045535.GA2242@yoda.dummynet> <Pine.LNX.4.10.10203192105490.525-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linux-ide.org> remarked:
> 
> append="ide=reverse"

You're right, this works, too, and is a lot easier to remember than
the override I used before.  

> Various Mainboard manufacturers do things to place the FAKE-RAID in front
> of the the legacy south bridge.  This is classic Windows spoofing.
> 
> > PDC20265: IDE controller on PCI bus 00 dev 68
> > VP_IDE: IDE controller on PCI bus 00 dev 89

So, the I/O port assignments don't in fact properly determine the
assignment order?  I'm gathering from what you're saying that the
current behavior is related to PCI bus location?

Thanks,
Dan
