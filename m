Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbTIDSwm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265504AbTIDSwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:52:42 -0400
Received: from sponsa.its.uu.se ([130.238.7.36]:56992 "EHLO sponsa.its.uu.se")
	by vger.kernel.org with ESMTP id S265499AbTIDSwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:52:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16215.35303.779396.809855@gargle.gargle.HOWL>
Date: Thu, 4 Sep 2003 20:52:23 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling an i386 kernel on AMD Opteron
In-Reply-To: <20030904192421.5b176adf.skraw@ithnet.com>
References: <20030904115209.56e019b1.skraw@ithnet.com>
	<16215.4277.540644.262286@gargle.gargle.HOWL>
	<20030904192421.5b176adf.skraw@ithnet.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski writes:
 > On Thu, 4 Sep 2003 12:15:17 +0200
 > Mikael Pettersson <mikpe@csd.uu.se> wrote:
 > 
 > > Stephan von Krawczynski writes:
 > >  > Hello,
 > >  > 
 > >  > is it possible to compile a kernel on Opteron for i386 (32-bit) and not 64
 > >  > bit Opteron with usual make procedures?
 > >  > 
 > >  > When I do a simple "make menuconfig" I can only see the Opteron processor
 > >  > type in "Processor type and features" ...
 > > 
 > > You need to learn about cross-compilation.
 > 
 > Do you really call it cross-compilation if you are working on a 32-bit linux
 > (Opteron driven) and try to compile a new kernel for the very same box?

Not if you're running a 32-bit kernel on the Opteron, but your statement above,
 > >  > When I do a simple "make menuconfig" I can only see the Opteron processor
 > >  > type in "Processor type and features" ...
indicated (to me at least) that you were running a 64-bit kernel.

What does `uname -m' say?

make mrproper and try again?
