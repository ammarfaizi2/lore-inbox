Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318133AbSG2Xlf>; Mon, 29 Jul 2002 19:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSG2Xlf>; Mon, 29 Jul 2002 19:41:35 -0400
Received: from [195.223.140.120] ([195.223.140.120]:18464 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318133AbSG2Xle>; Mon, 29 Jul 2002 19:41:34 -0400
Date: Tue, 30 Jul 2002 01:45:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Theurer <habanero@us.ibm.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
Message-ID: <20020729234558.GM1201@dualathlon.random>
References: <200207291454.30076.habanero@us.ibm.com> <1027978122.4050.22.camel@irongate.swansea.linux.org.uk> <20020729203840.GA1201@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729203840.GA1201@dualathlon.random>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 10:38:40PM +0200, Andrea Arcangeli wrote:
> On Mon, Jul 29, 2002 at 10:28:42PM +0100, Alan Cox wrote:
> > On Mon, 2002-07-29 at 20:54, Andrew Theurer wrote:
> > > I would caution against having hyperthreading on by default in the 2.4.19 
> > > release.  I am seeing a significant degrade in network workloads on P4 with 
> > > hyperthreading on.  On 2.4.19-pre10, I get 788 Mbps on NetBench, but on 
> > > 2.4.19-rc1 (and probably rc3, should know in an hour), I get 690 Mbps.  It is 
> > > clearly a hyperthreading/interrupt routing issue.  On this system (4 x P4), 
> > 
> > Quite possibly. I've just merged the O(1) scheduler load balancing fixes
> > for the hyperthreading stuff, rc3 uses the old scheduler so that isnt
> 
> btw, please make sure to merge my patch, the original one had several
> severe bugs.

and the new one had a bug too :). Please merge the fix I posted to l-k
too thanks.

Andrea
