Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSLML57>; Fri, 13 Dec 2002 06:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSLML5h>; Fri, 13 Dec 2002 06:57:37 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8196 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262712AbSLML4z>;
	Fri, 13 Dec 2002 06:56:55 -0500
Date: Thu, 12 Dec 2002 19:09:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Daniel Egger <degger@fhm.edu>, Dave Jones <davej@codemonkey.org.uk>,
       Joseph <jospehchan@yahoo.com.tw>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
Message-ID: <20021212180957.GA184@elf.ucw.cz>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw> <20021210055215.GA9124@suse.de> <1039504941.30881.10.camel@sonja> <200212110829.gBB8Tja05013@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212110829.gBB8Tja05013@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I believe someone (Jeff Garzik?) benchmarked gcc code generation,
> > > and the C3 executed code scheduled for a 486 faster than it did for
> > > -m586
> > > I'm not sure about the alignment flags. I've been meaning to look
> > > into that myself...
> >
> > Interesting. I have no clue about which C3 you're talking about here
> > but a VIA Ezra has all 686 instructions including cmov and thus
> > optimising for PPro works best for me.
> >
> > Prolly I would have to do more benchmarking to find out about
> > aligment advantages.
> 
> I heard cmovs are microcoded in Centaurs.
> 
> s...l...o...w...

It still might be faster then a branch... or not if centaurs are
really that simple.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
