Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318293AbSHZTdi>; Mon, 26 Aug 2002 15:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318294AbSHZTdh>; Mon, 26 Aug 2002 15:33:37 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:31456 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S318293AbSHZTdf>; Mon, 26 Aug 2002 15:33:35 -0400
Date: Mon, 26 Aug 2002 12:27:52 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Volker Kuhlmann <list0570@paradise.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel losing time
Message-ID: <20020826122752.A1547@linux-m68k.org>
References: <20020825105500.GE11740@paradise.net.nz> <Pine.LNX.4.44.0208250459500.3234-100000@hawkeye.luckynet.adm> <20020825215515.GA2965@debill.org> <1030320314.16766.25.camel@irongate.swansea.linux.org.uk> <20020826011332.GA8440@paradise.net.nz> <1030356936.16651.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1030356936.16651.37.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Aug 26, 2002 at 11:15:36AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 11:15:36AM +0100, Alan Cox wrote:

> ISA multi I/O without hdparm -u has sometimes done this kind of thing
> (since its slow and PIO). 

actually it still does that in 2.4.18 at least, even with 
hdparm -u. The effect is not dramatic though, less than
a second/day with normal activity. I've only noticed it 
while debugging the genrtc driver.

Richard
