Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUBHBCp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUBHBCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:02:42 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38599 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261606AbUBHBCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:02:40 -0500
Date: Sun, 8 Feb 2004 02:02:37 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Robert F Merrill <griever@t2n.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-mm1 won't compile (been doing this since 2.6.1-mm2 or so)
Message-ID: <20040208010237.GF7388@fs.tum.de>
References: <402558C0.5010100@t2n.org> <20040207213646.GE7388@fs.tum.de> <40256116.9050206@t2n.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40256116.9050206@t2n.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 05:05:10PM -0500, Robert F Merrill wrote:
> Adrian Bunk wrote:
> 
> >It seems when you did "make oldconfig" you said "no" to all cpu options.
> >
> >You should select the cpu type(s) you want to run your kernel on.
> >
> >Run "make menuconfig" and select the appropriate cpu types in
> > Processor type and features
> >   Processor support
> >
> >cu
> >Adrian
> >
> > 
> >
> Hm... how did that happen?

During "make oldconfig" you saw

  Select all processors your kernel should support


After this, you were prompted for every single supported cpu type.

It seems you said "no" to all cpu types including the one your computer 
has?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

