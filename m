Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263545AbTKXAb1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 19:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263546AbTKXAb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 19:31:26 -0500
Received: from intra.cyclades.com ([64.186.161.6]:11196 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263545AbTKXAam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 19:30:42 -0500
Date: Sun, 23 Nov 2003 22:25:10 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: modular IDE in 2.4.23
In-Reply-To: <200311232226.08882.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0311232224510.1292-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Nov 2003, Bartlomiej Zolnierkiewicz wrote:

> On Sunday 23 of November 2003 21:56, Alan Cox wrote:
> > > Uh. Oh. 2.4.23 IDE changes are obscure...  Modular IDE breakage is caused
> > > by Alan's hotplug changes and is not easy to fix properly.
> >
> > The fixing is simply a matter of linkage ordering and function execution.
> >
> > Simple thought experiment
> >
> > 	Merge ide-probe into ide-core
> > 	Export a symbol for the second initializer function if used modular
> > 	Create a mini module that just invokes the exported function on init
> 
> Update ide_probe_module() for new name of probe module.
> 
> > You now have the same execution sequence but with the link problem removed.
> 
> Hmm, actually you are right.  Sorry :-).

So mind you or Alan write a patch for me, please? 


