Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbTDWNiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264035AbTDWNiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:38:10 -0400
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:24069 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264034AbTDWNiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:38:09 -0400
Date: Wed, 23 Apr 2003 15:49:54 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Dave Mehler <dmehler26@woh.rr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.68 kernel no initrd
In-Reply-To: <1050859494.595.4.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.51L.0304231547460.12634@piorun.ds.pg.gda.pl>
References: <000701c306f6$cf100180$0200a8c0@satellite>
 <1050859494.595.4.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003, Felipe Alfaro Solana wrote:
> > Ok, i should learn to leave well enough alone, but i don't. After
> > successfully installing a monolithic 2.5.67 kernel i decided i wanted
> > modules, so i made them, and what happened, it hung after the initrd
> > initialized. So, when 2.5.68 came out i of course grab it,
> > compile/install it without a hitch, but for one thing, as of now make
> > install did not make an initrd for that install. Does anyone know how
> > to make this manually, it won't boot without one?
> I don't have experience with initrd, but why would you want a initrd?
> Can't you simply build into the kernel the required pieces to mount the
> root filesystem and leave the rest as loadable modules?

initrd gives much more flexibility.
I can make one kernel and use it on _all_ of my mashines, just change 
initrd. quick, nice and flexible with proper initrd tools set.

-- 
pozdr.  Pawe³ Go³aszewski        
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
