Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317774AbSFMQMi>; Thu, 13 Jun 2002 12:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317775AbSFMQMh>; Thu, 13 Jun 2002 12:12:37 -0400
Received: from dsl093-058-082.blt1.dsl.speakeasy.net ([66.93.58.82]:3830 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S317774AbSFMQMh>; Thu, 13 Jun 2002 12:12:37 -0400
Date: Thu, 13 Jun 2002 12:12:37 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
X-X-Sender: <becker@presario>
To: Matthew Hall <matt@ecsc.co.uk>
cc: Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] sundance on d-link dfe-580tx
In-Reply-To: <1023980246.1090.25.camel@smelly.dark.lan>
Message-ID: <Pine.LNX.4.33.0206131201480.1828-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jun 2002, Matthew Hall wrote:

> Subject: Re: [PROBLEM] sundance on d-link dfe-580tx
>
> 	I have tried and tested the sundance.c file as you indicated, and the
> netdrivers packages with a recompiled kernel, yet we still cannot get
> this (damn) card working :)

You are still running the old driver, not the driver at
   http://www.scyld.com/network/ethercard.html
      ftp://www.scyld.com/pub/network/sundance.c

> Just in case you can provide any more insight into this I compiled the
> alta-diag tool, for debugging purposes, the results of -aa, -ee and -mm
> are attached, aswell as the full detection message from dmesg after
> modprob'ing the module.

I never released a "1.01b" driver in January 2002.  The 1.01a driver was
released about two years ago.  The current version is
sundance.c:v1.06 1/28/2002

The diagnostic program is reading the correct station address, however
the driver you are using is reading a bogus address.  I believe that
that my driver release should correctly work with this card.

-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993


