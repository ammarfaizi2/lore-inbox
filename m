Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317986AbSHLNSC>; Mon, 12 Aug 2002 09:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317987AbSHLNSC>; Mon, 12 Aug 2002 09:18:02 -0400
Received: from sprocket.loran.com ([209.167.240.9]:3322 "EHLO
	ottonexc1.peregrine.com") by vger.kernel.org with ESMTP
	id <S317986AbSHLNSA>; Mon, 12 Aug 2002 09:18:00 -0400
Subject: Re: actiontec PCI call waiting modem not responding with kernels
	2.4.7+, 2.4.6 is ok though..
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: Steven Walter <srwalter@yahoo.com>
Cc: Blaise <jblaiseg@bellsouth.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020811053156.GA17530@hapablap.dns2go.com>
References: <3D5569B4.4010500@bellsouth.net> 
	<20020811053156.GA17530@hapablap.dns2go.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Aug 2002 09:21:49 -0400
Message-Id: <1029158509.31368.108.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-11 at 01:31, Steven Walter wrote:
> Wow, these reports are coming out of the woodwork all of a sudden.  Just
> yesterday I got an email from a guy with the same (probably) problem.  I
> own an Actiontec PCI call waiting modem, and it works fine with every
> version of Linux I've thrown at it; I like it.
> 
> First things first:  are you using setserial to set up the modem?  If
> so, cut it out.  Modern 2.4 kernels autodetect and setup everything
> themselves (Not sure when that started; possibly 2.4.7).  Anyway, try
> using /dev/ttyS4 as your modem device and see what happens; that is the
> first PCI serial port.
> 
> Let me know.

Another confirmed "working" report.

If you're using devfs it's easy to tell if it's tts/4 or tts/2 or
whatever, but assuming you're not using setserial and you're using
the right ttyS it works fine (using the actiontec and IBM versions
of the same card, based on the lucent venus chipset, with
2.4.everything)

Dana Lacoste
Ottawa, Canada

