Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293500AbSBZDjn>; Mon, 25 Feb 2002 22:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293498AbSBZDjd>; Mon, 25 Feb 2002 22:39:33 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:4623 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S293497AbSBZDjR>; Mon, 25 Feb 2002 22:39:17 -0500
Date: Mon, 25 Feb 2002 22:39:17 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Dan Hopper <dbhopper@austin.rr.com>, lkml <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.5.5-pre1 rmmod usb-uhci hangs
Message-ID: <20020225223917.I6516@sventech.com>
In-Reply-To: <fa.dsb79pv.on84ii@ifi.uio.no> <20020224025411.GA2418@yoda.dummynet> <20020224062124.GB15060@kroah.com> <20020224063915.GA2799@yoda.dummynet> <20020224064931.GD15060@kroah.com> <20020224173711.GA2355@yoda.dummynet> <20020224125055.A5232@sventech.com> <20020224184943.GA2492@yoda.dummynet> <20020224224107.D17788@sventech.com> <20020226032243.GA1931@yoda.dummynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020226032243.GA1931@yoda.dummynet>; from dbhopper@austin.rr.com on Mon, Feb 25, 2002 at 09:22:43PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002, Dan Hopper <dbhopper@austin.rr.com> wrote:
> Johannes Erdfelt <johannes@erdfelt.com> remarked:
> > Can you give this patch a whirl? It's relative to 2.4.18-rc2-gregkh-1
> 
> Sorry, didn't make any difference to the scanner.  
> 
> Now, in case it wasn't clear, the scanner does work, it just bumps
> and grinds it's way down the page in the process with uhci, taking
> considerably longer than with usb-uhci.  Very curious.

I understand what you're talking about, but I'm not sure what is causing
it.

The patch I sent fixed a performance problem where FSBR would turn off
too much. It could cause problems with devices like your scanner where
it would stutter.

> Thanks for the patch, though!

Hmm, I'll do a once over of the scanner.c source and see if I can find
anything.

JE

